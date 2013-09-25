module Stupidedi
  module Contrib
    module TwoThousandOne
      module TransactionSetDefs
        d = Schema
        r = SegmentReqs
        s = SegmentDefs

        PO830 = d::TransactionSetDef.build("PO", "830", "Material Release for Manufacturing",

          d::TableDef.header("Table 1 - Header",
            s:: ST.use( 10, r::Mandatory, d::RepeatCount.bounded(1)),          
            s::BFR.use( 20, r::Mandatory, d::RepeatCount.bounded(1))),

          d::TableDef.detail("Table 2 - Detail",
            d::LoopDef.build("N1", d::RepeatCount.bounded(1),
              s:: N1.use(  90, r::Optional, d::RepeatCount.bounded(1))),

            d::LoopDef.build("N1", d::RepeatCount.bounded(1),
              s:: N1.use(  90, r::Optional, d::RepeatCount.bounded(1)),
              s::PER.use( 140, r::Optional, d::RepeatCount.bounded(3))),

            d::LoopDef.build("LIN", d::RepeatCount.bounded(10000),
              s::LIN.use( 300, r::Mandatory, d::RepeatCount.bounded(1)), 
              s::UNT.use( 310, r::Mandatory, d::RepeatCount.bounded(1)),
              s::J2X.use( 330, r::Optional, d::RepeatCount.bounded(1)),
              s::PER.use( 450, r::Optional, d::RepeatCount.bounded(1)),

              d::LoopDef.build("N1", d::RepeatCount.bounded(1),
                s:: N1.use(  510, r::Optional, d::RepeatCount.bounded(1))),

              d::LoopDef.build("SDP", d::RepeatCount.bounded(104),
                s::SDP.use( 580, r::Mandatory, d::RepeatCount.bounded(1)), 
                s::FST.use( 590, r::Mandatory, d::RepeatCount.bounded(1))),
                
              s::ATH.use( 330, r::Optional, d::RepeatCount.bounded(2)),
              s::TD5.use( 450, r::Optional, d::RepeatCount.bounded(1)),
              s::MAN.use( 450, r::Optional, d::RepeatCount.bounded(1)))),

          d::TableDef.summary("Table 3 - Summary",
            s::CTT.use(380, r::Mandatory, d::RepeatCount.bounded(1)),
            s:: SE.use(390, r::Mandatory, d::RepeatCount.bounded(1))))

      end
    end
  end
end