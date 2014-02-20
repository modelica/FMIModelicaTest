within FMITest.MixedSystems;
package AutomaticGearbox
  "Test of coupled clutches and brakes with Boolean open/close flags leading to a mixed system of equations with Real and Booleans in the interfaces between FMUs"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Force fn_max=1000;
    Modelica.Mechanics.Rotational.Components.IdealPlanetary planetary1(ratio=
          100/40) annotation (Placement(transformation(extent={{22,-32},{42,-12}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealPlanetary planetary2(ratio=
          100/20) annotation (Placement(transformation(extent={{86,-32},{106,-12}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Clutch C1(
      fn_max=fn_max,
      stateSelect=StateSelect.always,
      phi_rel(fixed=true),
      w_rel(fixed=true)) annotation (Placement(transformation(extent={{-68,8},{
              -48,28}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Clutch C2(
      fn_max=fn_max,
      phi_rel(fixed=true),
      w_rel(fixed=true),
      stateSelect=StateSelect.always) annotation (Placement(transformation(
            extent={{-68,-32},{-48,-12}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake B2(fn_max=fn_max, useSupport
        =false) annotation (Placement(transformation(extent={{-10,-32},{10,-12}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Brake B1(
      fn_max=fn_max,
      useSupport=false,
      phi(start=0, fixed=false),
      w(start=0, fixed=false)) annotation (Placement(transformation(extent={{55,
              -13},{75,7}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=2,
      phi(fixed=true, start=0),
      w(fixed=true, start=0),
      stateSelect=StateSelect.always) annotation (Placement(transformation(
            extent={{-98,-32},{-78,-12}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
      annotation (Placement(transformation(extent={{-82,-90},{-62,-70}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=0.2,
      phi(fixed=false),
      w(fixed=false)) annotation (Placement(transformation(extent={{-38,-32},{-18,
              -12}}, rotation=0)));
    Modelica.Blocks.Sources.Constant const(k=250) annotation (Placement(
          transformation(extent={{-118,-90},{-98,-70}}, rotation=0)));
    FMITest.MixedSystems.AutomaticGearbox.FMUModels.ECU ecu annotation (
        Placement(transformation(
          origin={-10,102},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=3, useSupport
        =false) annotation (Placement(transformation(extent={{-28,-92},{-8,-72}},
            rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealGearR2T r2t(
      ratio=1/0.3,
      useSupportR=false,
      useSupportT=false) annotation (Placement(transformation(extent={{12,-92},
              {32,-72}},rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass mass(
      m=1000,
      s(fixed=false, start=0),
      v(fixed=false, start=0)) annotation (Placement(transformation(extent={{52,
              -92},{72,-72}}, rotation=0)));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(extent={{92,-92},{112,-72}},
            rotation=0)));
    Modelica.Blocks.Math.BooleanToReal c1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-58,52})));
    Modelica.Blocks.Math.BooleanToReal c2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-30,52})));
    Modelica.Blocks.Math.BooleanToReal b1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-2,52})));
    Modelica.Blocks.Math.BooleanToReal b2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={28,52})));
  equation
    connect(B2.flange_b, planetary1.sun)
      annotation (Line(points={{10,-22},{22,-22}}, thickness=0.5));
    connect(inertia1.flange_b, C2.flange_a) annotation (Line(
        points={{-78,-22},{-68,-22}},
        color={0,0,255},
        thickness=0.5));
    connect(torque.flange, inertia1.flange_a) annotation (Line(
        points={{-62,-80},{-56,-80},{-56,-58},{-104,-58},{-104,-22},{-98,-22}},

        color={0,0,255},
        thickness=0.5));

    connect(const.y, torque.tau)
      annotation (Line(points={{-97,-80},{-84,-80}}));
    connect(C2.flange_a, C1.flange_a) annotation (Line(
        points={{-68,-22},{-72,-22},{-72,18},{-68,18}},
        color={0,0,255},
        thickness=0.5));
    connect(C2.flange_b, inertia2.flange_a)
      annotation (Line(points={{-48,-22},{-38,-22}}, thickness=0.5));
    connect(inertia2.flange_b, B2.flange_a)
      annotation (Line(points={{-18,-22},{-10,-22}}, thickness=0.5));
    connect(planetary1.carrier, planetary2.ring) annotation (Line(
        points={{22,-18},{17,-18},{17,28},{112,28},{112,-22},{106,-22}},
        color={0,255,0},
        thickness=0.5));
    connect(planetary1.sun, planetary2.sun) annotation (Line(points={{22,-22},{
            16,-22},{16,-46},{70,-46},{70,-22},{86,-22}}, thickness=0.5));
    connect(planetary1.ring, C1.flange_b) annotation (Line(points={{42,-22},{46,
            -22},{46,18},{-48,18}}, thickness=0.5));
    connect(planetary2.carrier, B1.flange_b) annotation (Line(
        points={{86,-18},{80,-18},{80,-3},{75,-3}},
        color={0,0,255},
        thickness=0.5));
    connect(gear.flange_b, r2t.flangeR)
      annotation (Line(points={{-8,-82},{12,-82}}, color={0,0,0}));
    connect(r2t.flangeT, mass.flange_a)
      annotation (Line(points={{32,-82},{52,-82}}, color={0,191,0}));
    connect(mass.flange_b, speedSensor.flange)
      annotation (Line(points={{72,-82},{92,-82}}, color={0,191,0}));
    connect(planetary2.ring, gear.flange_a) annotation (Line(
        points={{106,-22},{123,-22},{123,-56},{-34,-56},{-34,-82},{-28,-82}},
        color={0,0,0},
        thickness=0.5));
    connect(ecu.C1, c1.u) annotation (Line(
        points={{-26,80},{-26,78},{-58,78},{-58,64}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(c1.y, C1.f_normalized) annotation (Line(
        points={{-58,41},{-58,29}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ecu.C2, c2.u) annotation (Line(
        points={{-18,80},{-18,72},{-30,72},{-30,64}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(c2.y, C2.f_normalized) annotation (Line(
        points={{-30,41},{-30,-2},{-58,-2},{-58,-11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ecu.B1, b1.u) annotation (Line(
        points={{-2,80},{-2,64}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(b1.y, B1.f_normalized) annotation (Line(
        points={{-2,41},{-2,34},{65,34},{65,8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ecu.B2, b2.u) annotation (Line(
        points={{6,80},{6,72},{28,72},{28,64}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(b2.y, B2.f_normalized) annotation (Line(
        points={{28,41},{28,24},{0,24},{0,-11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.v, ecu.speed) annotation (Line(
        points={{113,-82},{130,-82},{130,136},{-10,136},{-10,126}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{
              160,140}}), graphics={
          Rectangle(extent={{-126,-54},{-50,-98}}, lineColor={255,0,0}),
          Rectangle(extent={{-38,-52},{136,-98}}, lineColor={255,0,0}),
          Text(
            extent={{-112,-100},{-64,-110}},
            lineColor={255,0,0},
            textString="engine"),
          Text(
            extent={{-4,-102},{116,-112}},
            lineColor={255,0,0},
            textString="differential + wheel + car"),
          Rectangle(extent={{-114,38},{136,-48}}, lineColor={255,0,0}),
          Text(
            extent={{-124,54},{-72,42}},
            lineColor={255,0,0},
            textString="automatic gear"),
          Text(
            extent={{54,-92},{72,-98}},
            lineColor={0,0,255},
            textString="m=1000")}),
      experiment(StopTime=10),
      Documentation(info="<html>
<p>
The parameters are selected so that both friction elements are partly  
sliding (mode = +/- 1) or partly stuck (mode = 0). Plot the following variables:
</p>

<p>
<img src=\"modelica://FMITest/Resources/Images/TwoFriction1.png\">
</p>

<p>
<img src=\"modelica://FMITest/Resources/Images/TwoFriction2.png\">
</p>
</html>"));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.AutomaticGear automaticGear
      annotation (Placement(transformation(extent={{-18,0},{2,20}})));
    FMUModels.ECU eCU annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-8,50})));
  equation
    connect(eCU.C2, automaticGear.c2) annotation (Line(
        points={{-12,39},{-12,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B1, automaticGear.b1) annotation (Line(
        points={{-4,39},{-4,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(automaticGear.v, eCU.speed) annotation (Line(
        points={{5,10},{30,10},{30,72},{-8,72},{-8,62},{-8,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(eCU.C1, automaticGear.c1) annotation (Line(
        points={{-16,39},{-16,30},{-18,30},{-18,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B2, automaticGear.b2) annotation (Line(
        points={{0,39},{0,32},{2,32},{2,22}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=10));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.AutomaticGear automaticGear
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.ECU eCU annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-10,50})));
  equation
    connect(eCU.C2, automaticGear.c2) annotation (Line(
        points={{-14,39},{-14,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B1, automaticGear.b1) annotation (Line(
        points={{-6,39},{-6,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(automaticGear.v, eCU.speed) annotation (Line(
        points={{3,10},{28,10},{28,72},{-10,72},{-10,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(eCU.C1, automaticGear.c1) annotation (Line(
        points={{-18,39},{-18,30},{-20,30},{-20,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B2, automaticGear.b2) annotation (Line(
        points={{-2,39},{-2,32},{0,32},{0,22}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=10));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model AutomaticGear

      parameter Modelica.SIunits.Force fn_max=1000;
      Modelica.Mechanics.Rotational.Components.IdealPlanetary planetary1(ratio=
            100/40) annotation (Placement(transformation(extent={{22,-32},{42,-12}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary planetary2(ratio=
            100/20) annotation (Placement(transformation(extent={{86,-32},{106,
                -12}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Clutch C1(
        fn_max=fn_max,
        stateSelect=StateSelect.always,
        phi_rel(fixed=true),
        w_rel(fixed=true)) annotation (Placement(transformation(extent={{-68,8},
                {-48,28}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Clutch C2(
        fn_max=fn_max,
        phi_rel(fixed=true),
        w_rel(fixed=true),
        stateSelect=StateSelect.always) annotation (Placement(transformation(
              extent={{-68,-32},{-48,-12}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Brake B2(fn_max=fn_max,
          useSupport=false) annotation (Placement(transformation(extent={{-10,-32},
                {10,-12}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Brake B1(fn_max=fn_max,
          useSupport=false) annotation (Placement(transformation(extent={{55,-13},
                {75,7}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0),
        stateSelect=StateSelect.always) annotation (Placement(transformation(
              extent={{-98,-32},{-78,-12}}, rotation=0)));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
        annotation (Placement(transformation(extent={{-82,-90},{-62,-70}},
              rotation=0)));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(
        J=0.2,
        phi(fixed=false),
        w(fixed=false)) annotation (Placement(transformation(extent={{-38,-32},
                {-18,-12}}, rotation=0)));
      Modelica.Blocks.Sources.Constant const(k=250) annotation (Placement(
            transformation(extent={{-118,-90},{-98,-70}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=3,
          useSupport=false) annotation (Placement(transformation(extent={{-28,-92},
                {-8,-72}}, rotation=0)));
      Modelica.Mechanics.Rotational.Components.IdealGearR2T r2t(
        ratio=1/0.3,
        useSupportR=false,
        useSupportT=false) annotation (Placement(transformation(extent={{12,-92},
                {32,-72}}, rotation=0)));
      Modelica.Mechanics.Translational.Components.Mass mass(
        m=1000,
        s(fixed=false),
        v(fixed=false)) annotation (Placement(transformation(extent={{52,-92},{
                72,-72}}, rotation=0)));
      Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor
        annotation (Placement(transformation(extent={{92,-92},{112,-72}},
              rotation=0)));
      Modelica.Blocks.Math.BooleanToReal c1b annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-60,52})));
      Modelica.Blocks.Math.BooleanToReal c2b annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-30,52})));
      Modelica.Blocks.Math.BooleanToReal b1b annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,52})));
      Modelica.Blocks.Math.BooleanToReal b2b annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={28,52})));
      Modelica.Blocks.Interfaces.BooleanInput c1 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-60,120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-100,120})));
      Modelica.Blocks.Interfaces.BooleanInput c2 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-30,120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-40,120})));
      Modelica.Blocks.Interfaces.BooleanInput b1 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={40,120})));
      Modelica.Blocks.Interfaces.BooleanInput b2 annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={28,120}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={100,120})));
      Modelica.Blocks.Interfaces.RealOutput v annotation (Placement(
            transformation(extent={{160,-10},{180,10}}), iconTransformation(
              extent={{120,-10},{140,10}})));
    equation
      connect(B2.flange_b, planetary1.sun)
        annotation (Line(points={{10,-22},{22,-22}}, thickness=0.5));
      connect(inertia1.flange_b, C2.flange_a) annotation (Line(
          points={{-78,-22},{-68,-22}},
          color={0,0,255},
          thickness=0.5));
      connect(torque.flange, inertia1.flange_a) annotation (Line(
          points={{-62,-80},{-56,-80},{-56,-58},{-104,-58},{-104,-22},{-98,-22}},

          color={0,0,255},
          thickness=0.5));

      connect(const.y, torque.tau)
        annotation (Line(points={{-97,-80},{-84,-80}}));
      connect(C2.flange_a, C1.flange_a) annotation (Line(
          points={{-68,-22},{-72,-22},{-72,18},{-68,18}},
          color={0,0,255},
          thickness=0.5));
      connect(C2.flange_b, inertia2.flange_a)
        annotation (Line(points={{-48,-22},{-38,-22}}, thickness=0.5));
      connect(inertia2.flange_b, B2.flange_a)
        annotation (Line(points={{-18,-22},{-10,-22}}, thickness=0.5));
      connect(planetary1.carrier, planetary2.ring) annotation (Line(
          points={{22,-18},{17,-18},{17,28},{112,28},{112,-22},{106,-22}},
          color={0,255,0},
          thickness=0.5));
      connect(planetary1.sun, planetary2.sun) annotation (Line(points={{22,-22},
              {16,-22},{16,-46},{70,-46},{70,-22},{86,-22}}, thickness=0.5));
      connect(planetary1.ring, C1.flange_b) annotation (Line(points={{42,-22},{
              46,-22},{46,18},{-48,18}}, thickness=0.5));
      connect(planetary2.carrier, B1.flange_b) annotation (Line(
          points={{86,-18},{80,-18},{80,-3},{75,-3}},
          color={0,0,255},
          thickness=0.5));
      connect(gear.flange_b, r2t.flangeR)
        annotation (Line(points={{-8,-82},{12,-82}}, color={0,0,0}));
      connect(r2t.flangeT, mass.flange_a)
        annotation (Line(points={{32,-82},{52,-82}}, color={0,191,0}));
      connect(mass.flange_b, speedSensor.flange)
        annotation (Line(points={{72,-82},{92,-82}}, color={0,191,0}));
      connect(planetary2.ring, gear.flange_a) annotation (Line(
          points={{106,-22},{123,-22},{123,-56},{-34,-56},{-34,-82},{-28,-82}},

          color={0,0,0},
          thickness=0.5));

      connect(c1b.y, C1.f_normalized) annotation (Line(
          points={{-60,41},{-60,36},{-58,36},{-58,29}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(c2b.y, C2.f_normalized) annotation (Line(
          points={{-30,41},{-30,-2},{-58,-2},{-58,-11}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(b1b.y, B1.f_normalized) annotation (Line(
          points={{-1.9984e-015,41},{-1.9984e-015,34},{65,34},{65,8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(b2b.y, B2.f_normalized) annotation (Line(
          points={{28,41},{28,24},{0,24},{0,-11}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(c1b.u, c1) annotation (Line(
          points={{-60,64},{-60,120},{-60,120}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(c2b.u, c2) annotation (Line(
          points={{-30,64},{-30,120},{-30,120}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(b1b.u, b1) annotation (Line(
          points={{0,64},{0,64},{0,120}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(b2b.u, b2) annotation (Line(
          points={{28,64},{28,120}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(speedSensor.v, v) annotation (Line(
          points={{113,-82},{148,-82},{148,0},{170,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},
                {160,140}}), graphics={
            Rectangle(extent={{-126,-54},{-50,-98}}, lineColor={255,0,0}),
            Rectangle(extent={{-38,-52},{136,-98}}, lineColor={255,0,0}),
            Text(
              extent={{-112,-100},{-64,-110}},
              lineColor={255,0,0},
              textString="engine"),
            Text(
              extent={{-4,-102},{116,-112}},
              lineColor={255,0,0},
              textString="differential + wheel + car"),
            Rectangle(extent={{-114,38},{136,-48}}, lineColor={255,0,0}),
            Text(
              extent={{-124,54},{-72,42}},
              lineColor={255,0,0},
              textString="automatic gear"),
            Text(
              extent={{54,-92},{72,-98}},
              lineColor={0,0,255},
              textString="m=1000")}),
        experiment(StopTime=10),
        Documentation(info="<html>
<p>
The parameters are selected so that both friction elements are partly  
sliding (mode = +/- 1) or partly stuck (mode = 0). Plot the following variables:
</p>

<p>
<img src=\"modelica://FMITest/Resources/Images/TwoFriction1.png\">
</p>

<p>
<img src=\"modelica://FMITest/Resources/Images/TwoFriction2.png\">
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{120,-100},{-120,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-120,94},{-70,58}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="C1"),
            Text(
              extent={{-66,94},{-16,58}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="C2"),
            Text(
              extent={{12,94},{62,58}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="B1"),
            Text(
              extent={{72,94},{122,58}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="B2"),
            Text(
              extent={{64,18},{114,-18}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="v"),
            Text(
              extent={{-72,-49},{36,-81}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end AutomaticGear;

    model ECU
      "Very simple electronic control unit to control clutches C1, C2 and brakes B1, B2"

      import SI = Modelica.SIunits;
      parameter SI.Time t_start=1
        "Time instant when the driver switches from 'N' to 'D', i.e., when the car starts driving";
      parameter SI.Velocity v_up_12=10
        "Velocity to switch from gear 1 into gear 2";
      parameter SI.Velocity v_up_23=20
        "Velocity to switch from gear 2 into gear 3";
      Modelica.Blocks.Interfaces.BooleanOutput C1 annotation (Placement(
            transformation(extent={{100,-90},{120,-70}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput C2 annotation (Placement(
            transformation(extent={{100,-50},{120,-30}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput B1 annotation (Placement(
            transformation(extent={{100,30},{120,50}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput B2 annotation (Placement(
            transformation(extent={{100,70},{120,90}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput speed annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      Integer gear;

    equation
      gear = if time < t_start then 0 else if speed < v_up_12 then 1 else if
        speed < v_up_23 then 2 else 3;

      if gear == 0 then
        C1 = false;
        C2 = false;
        B1 = false;
        B2 = false;
      elseif gear == 1 then
        C1 = true;
        C2 = false;
        B1 = true;
        B2 = false;
      elseif gear == 2 then
        C1 = true;
        C2 = false;
        B1 = false;
        B2 = true;
      else
        C1 = true;
        C2 = true;
        B1 = false;
        B2 = false;
      end if;
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,48},{40,48},{16,-11},{-86,-10},{-60,48}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-86,-10},{16,-11},{16,-37},{-86,-37},{-86,-10}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{16,-11},{40,48},{40,27},{16,-37},{16,-11}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-122,-107},{113,-180}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="%name"),
            Text(
              extent={{33,95},{96,63}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="B2"),
            Text(
              extent={{33,54},{97,22}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="B1"),
            Text(
              extent={{32,-17},{97,-51}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="C2"),
            Text(
              extent={{32,-60},{97,-94}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="C1"),
            Text(
              extent={{-82,-59},{26,-91}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end ECU;
  end FMUModels;
  annotation (preferredView="Info");
end AutomaticGearbox;
