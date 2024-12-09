% Test DBPredator initialization and update

function didPass = test_UAV_Classes()
    clc
    didPass = false;

    try

        % Here is the stuff we will try and run

        % Create a predator object and a quad copter object
        predObj = DBPredator([1, 1], 2, 100);


        % quadObj = DBQuad([2, 2], 1.5, 100); % Position = [2, 2], MaxVelocity = 1.5, Armor = 100


        quadObj = DBQuad([], 1.5); % Position = [2, 2], MaxVelocity = 1.5, Armor = 100


        disp('UAV Success');
        didPass = true;

    catch me
        % if something went wrong above, we will be down here in the program
        disp('UAV Fail');

    end

end





% 
% 
% 
% 
% 
% 
% predator = DBPredator([]);
% % Test DBPredator
% 
%     try
%         % Initialize DBPredator with known values
%         disp(['Initializing DBPredator ', num2str(i)]);
%         predators(i) = DBPredator([1, 1], 2, 100); % Position = [1, 1], MaxVelocity = 2, Armor = 100
% 
%         % Save initial position
%         initialPosition = predators(i).Position;
%         disp(['Initial Position (Predator ', num2str(i), '): ', num2str(initialPosition)]);
% 
%         % Update DBPredator position with a known velocity
%         predators(i).update(0.1, [1, 0]); % Move right with velocity [1, 0]
% 
%         % Check if the position has changed significantly
%         expectedPosition = initialPosition + [0.1, 0];  % Expected change for 0.1s with velocity [1, 0]
%         disp(['New Position (Predator ', num2str(i), '): ', num2str(predators(i).Position)]);
% 
%         if norm(predators(i).Position - expectedPosition) > 0.1
%             error('DBPredator update failed');
%         end
%     catch
%         disp('DBPredator test failed');
%         testSuccess = false;
%     end
% end
% 
% % Test DBQuad
% for i = 1:numQuads
%     try
%         % Initialize DBQuad with known values
%         disp(['Initializing DBQuad ', num2str(i)]);
%         quads(i) = DBQuad([2, 2], 1.5, 100); % Position = [2, 2], MaxVelocity = 1.5, Armor = 100
% 
%         % Save initial position
%         initialPosition = quads(i).Position;
%         disp(['Initial Position (Quad ', num2str(i), '): ', num2str(initialPosition)]);
% 
%         % Update DBQuad position with a known velocity
%         quads(i).update(0.1, [0, 1]); % Move up with velocity [0, 1]
% 
%         % Check if the position has changed significantly
%         expectedPosition = initialPosition + [0, 0.1];  % Expected change for 0.1s with velocity [0, 1]
%         disp(['New Position (Quad ', num2str(i), '): ', num2str(quads(i).Position)]);
% 
%         if norm(quads(i).Position - expectedPosition) > 0.1
%             error('DBQuad update failed');
%         end
%     catch
%         disp('DBQuad test failed');
%         testSuccess = false;
%     end
% end
% 
% % Output final result
% if testSuccess
%     disp('All tests passed!');
% else
%     disp('Some tests failed.');
% end