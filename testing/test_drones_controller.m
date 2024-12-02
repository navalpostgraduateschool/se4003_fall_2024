function [didPass, dronesCtrl] = test_drones_controller()
    didPass = false;

    try
        axesH = initAxes();
        env = DBEnvironment(axesH);
        % use our method to create and initialize an axes handle.

        % Create the environment and such
        dronesCtrl = DBDronesController(axesH);
        duration_to_run_sec = 10;

        dronesCtrl.demo_run(duration_to_run_sec);
        didPass = true;
    catch me
        showME(me);
    end

    if didPass
        disp('Drones controller passed');
    else
        disp('Drones controller failed');
    end

end