function [Segments]=segments_moved(columns)

for i=1:length(columns)
    if columns(i)==1
        seg={'X Pelvis'};
    end
    if columns(i)==2
        seg={'Y Pelvis'};
    end
    if columns(i)==3
        seg={'Z Pelvis'};
    end
    if columns(i)==4
        seg={'X L5'};
    end
    if columns(i)==5
        seg={'Y L5'};
    end
    if columns(i)==6
        seg={'Z L5'};
    end
    if columns(i)==7
        seg={'X L3'};
    end
    if columns(i)==8
        seg={'Y L3'};
    end
    if columns(i)==9
        seg={'Z L3'};
    end
    if columns(i)==10
        seg={'X T12'};
    end
    if columns(i)==11
        seg={'Y T12'};
    end
    if columns(i)==12
        seg={'Z T12'};
    end
    if columns(i)==13
        seg={'X T8'};
    end
    if columns(i)==14
        seg={'Y T8'};
    end
    if columns(i)==15
        seg={'Z T8'};
    end
    if columns(i)==16
        seg={'X Neck'};
    end
    if columns(i)==17
        seg={'Y Neck'};
    end
    if columns(i)==18
        seg={'Z Neck'};
    end
    if columns(i)==19
        seg={'X Head'};
    end
    if columns(i)==20
        seg={'Y Head'};
    end
    if columns(i)==21
        seg={'Z Head'};
    end
    if columns(i)==22
        seg={'X Right Shoulder'};
    end
    if columns(i)==23
        seg={'Y Right Shoulder'};
    end
    if columns(i)==24
        seg={'Z Right Shoulder'};
    end
    if columns(i)==25
        seg={'X Right Upper Arm'};
    end
    if columns(i)==26
        seg={'Y Right Upper Arm'};
    end
    if columns(i)==27
        seg={'Z Right Upper Arm'};
    end
    if columns(i)==28
        seg={'X Right Forearm'};
    end
    if columns(i)==29
        seg={'Y Right Forearm'};
    end
    if columns(i)==30
        seg={'Z Right Forearm'};
    end
    if columns(i)==31
        seg={'X Right Hand'};
    end
    if columns(i)==32
        seg={'Y Right Hand'};
    end
    if columns(i)==33
        seg={'Z Right Hand'};
    end
    if columns(i)==34
        seg={'X Left Shoulder'};
    end
    if columns(i)==35
        seg={'Y Left Shoulder'};
    end
    if columns(i)==36
        seg={'Z Left Shoulder'};
    end
    if columns(i)==37
        seg={'X Left Upper Arm'};
    end
    if columns(i)==38
        seg={'Y Left Upper Arm'};
    end
    if columns(i)==39
        seg={'Z Left Upper Arm'};
    end
    if columns(i)==40
        seg={'X Left Forearm'};
    end
    if columns(i)==41
        seg={'Y Left Forearm'};
    end
    if columns(i)==42
        seg={'Z Left Forearm'};
    end
    if columns(i)==43
        seg={'X Left Hand'};
    end
    if columns(i)==44
        seg={'Y Left Hand'};
    end
    if columns(i)==45
        seg={'Z Left Hand'};
    end
    if columns(i)==46
        seg={'X Right Upper Leg'};
    end
    if columns(i)==47
        seg={'Y Right Upper Leg'};
    end
    if columns(i)==48
        seg={'Z Right Upper Leg'};
    end
    if columns(i)==49
        seg={'X Right Lower Leg'};
    end
    if columns(i)==50
        seg={'Y Right Lower Leg'};
    end
    if columns(i)==51
        seg={'Z Right Lower Leg'};
    end
    if columns(i)==52
        seg={'X Right Foot'};
    end
    if columns(i)==53
        seg={'Y Right Foot'};
    end
    if columns(i)==54
        seg={'Z Right Foot'};
    end
    if columns(i)==55
        seg={'X Right Toe'};
    end
    if columns(i)==56
        seg={'Y Right Toe'};
    end
    if columns(i)==57
        seg={'X Right Toe'};
    end
    if columns(i)==58
        seg={'Y Left Upper Leg'};
    end
    if columns(i)==59
        seg={'X Left Upper Leg'};
    end
    if columns(i)==60
        seg={'Z Left Upper Leg'};
    end
    if columns(i)==61
        seg={'X Left Lower Leg'};
    end
    if columns(i)==62
        seg={'Y Left Lower Leg'};
    end
    if columns(i)==63
        seg={'Z Left Lower Leg'};
    end
    if columns(i)==64
        seg={'X Left Foot'};
    end
    if columns(i)==65
        seg={'Y Left Foot'};
    end
    if columns(i)==66
        seg={'Z Left Foot'};
    end
    if columns(i)==67
        seg={'X Left Toe'};
    end
    if columns(i)==68
        seg={'Y Left Toe'};
    end
    if columns(i)==69
        seg={'Z Left Toe'};
    end
    
    Segments(i,:)=seg;
end

end

