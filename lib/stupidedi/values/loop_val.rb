module Stupidedi
  module Values

    class LoopVal < AbstractVal
      include SegmentValGroup

      # @return [LoopDef]
      attr_reader :definition

      # @return [Array<SegmentVal, LoopVal>]
      attr_reader :child_vals

      # @return [LoopVal, TableVal]
      attr_reader :parent

      def initialize(definition, child_vals, parent)
        @definition, @child_vals, @parent =
          definition, child_vals, parent

        # Delay re-parenting until the entire value tree has a root
        # to prevent unnecessarily copying objects
        unless parent.nil?
          @child_vals = child_vals.map{|x| x.copy(:parent => self) }
        end
      end

      # @return [LoopVal]
      def copy(changes = {})
        self.class.new \
          changes.fetch(:definition, @definition),
          changes.fetch(:child_vals, @child_vals),
          changes.fetch(:parent, @parent)
      end

      # @return [Array<SegmentVal>]
      def segment_vals
        @child_vals.select{|x| x.is_a?(SegmentVal) }
      end

      def empty?
        @child_vals.all(&:empty?)
      end

      # @return [LoopVal]
      def append(child_val)
        copy(:child_vals => child_val.snoc(@child_vals))
      end
      alias append_loop append
      alias append_segment append

      # @return [LoopVal]
      def append!(child_val)
        @child_vals = child_val.snoc(@child_vals)
        self
      end
      alias append_loop! append!
      alias append_segment! append!

      # @private
      def pretty_print(q)
        id = @definition.try{|l| "[#{l.id}]" }
        q.text("LoopVal#{id}")
        q.group(2, "(", ")") do
          q.breakable ""
          @child_vals.each do |e|
            unless q.current_group.first?
              q.text ","
              q.breakable
            end
            q.pp e
          end
        end
      end

      # @private
      def ==(other)
        other.definition == @definition and
        other.child_vals == @child_vals
      end
    end

  end
end
