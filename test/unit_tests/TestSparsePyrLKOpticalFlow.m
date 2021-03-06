classdef TestSparsePyrLKOpticalFlow
    %TestSparsePyrLKOpticalFlow

    methods (Static)
        function test_1
            im1 = 255*uint8([...
                0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0;...
                0 0 0 1 1 1 0 0 0 0;...
                0 0 0 1 0 1 0 0 0 0;...
                0 0 0 1 1 1 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0;...
                0 0 0 0 0 0 0 0 0 0;...
            ]);
            im2 = circshift(im1, [0 1]);
            alg = cv.SparsePyrLKOpticalFlow();
            pts = alg.calc(im1, im2, {[3,3]});
        end

        function test_2
            prevImg = cv.imread(fullfile(mexopencv.root(),'test','RubberWhale1.png'), ...
                'Grayscale',true, 'ReduceScale',2);
            nextImg = cv.imread(fullfile(mexopencv.root(),'test','RubberWhale2.png'), ...
                'Grayscale',true, 'ReduceScale',2);
            prevPts = cv.goodFeaturesToTrack(prevImg, 'MaxCorners',200);
            alg = cv.SparsePyrLKOpticalFlow();
            [nextPts,status,err] = alg.calc(prevImg, nextImg, prevPts);
            validateattributes(nextPts, {'cell'}, ...
                {'vector', 'numel',numel(prevPts)});
            cellfun(@(pt) validateattributes(pt, {'numeric'}, ...
                {'vector', 'numel',2}), nextPts);
            validateattributes(status, {'uint8'}, ...
                {'vector', 'binary', 'numel',numel(nextPts)});
            validateattributes(err, {'single'}, ...
                {'vector', 'real', 'numel',numel(nextPts)});
        end
    end

end
