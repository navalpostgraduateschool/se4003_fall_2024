function dronesCtrl = test_drones_controller()

    ax = initAxes();

    dronesLocation = [40, 40];

    dronesCtrl = DBDronesController(ax);
    dronesCtrl.setLocation(dronesLocation);
    dronesCtrl.initModel();


end