within FMITest.LinearSystems;
package InertiaAndRevolute
  "Test of the connection of a 1-dim. rotational inertia with a 3-dim. multi-body revolute joint leading to a linear system of equations"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
      annotation (Placement(transformation(extent={{-44,40},{-24,60}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=1, amplitude=0.5)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}}, rotation=
             0)));
    Modelica.Mechanics.MultiBody.Joints.Revolute rev(
      n={0,0,1},
      useAxisFlange=true,
      phi(fixed=true),
      w(fixed=true)) annotation (Placement(transformation(extent={{20,-40},{40,
              -20}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-12,30})));
    Modelica.Mechanics.MultiBody.Parts.Body body(m=1.0, r_CM={0.5,0,0})
      annotation (Placement(transformation(extent={{60,-40},{80,-20}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      phi(start=0),
      w(start=0),
      J=0.05) annotation (Placement(transformation(extent={{32,40},{52,60}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-44,4},{-24,24}})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(useSupport=
          true, ratio=3)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
  equation
    connect(sine.y, torque.tau) annotation (Line(
        points={{-59,50},{-46,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(world.frame_b, rev.frame_a) annotation (Line(
        points={{0,-30},{20,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(body.frame_a, rev.frame_b) annotation (Line(
        points={{60,-30},{40,-30}},
        color={95,95,95},
        thickness=0.5));
    connect(fixed.flange, torque.support) annotation (Line(
        points={{-34,14},{-34,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, damper.flange_b) annotation (Line(
        points={{-34,14},{-12,14},{-12,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fixed.flange, idealGear.support) annotation (Line(
        points={{-34,14},{10,14},{10,40}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(damper.flange_a, idealGear.flange_a) annotation (Line(
        points={{-12,40},{-12,50},{0,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque.flange, idealGear.flange_a) annotation (Line(
        points={{-24,50},{0,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(idealGear.flange_b, inertia.flange_a) annotation (Line(
        points={{20,50},{32,50}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia.flange_b, rev.axis) annotation (Line(
        points={{52,50},{66,50},{66,-8},{30,-8},{30,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=5));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.InverseDriveTrain inverseDriveTrain(J=0.05)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=1, amplitude=0.5)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    FMUModels.DirectPendulum directPendulum
      annotation (Placement(transformation(extent={{40,20},{20,40}})));
  equation
    connect(sine.y, inverseDriveTrain.driveTorque) annotation (Line(
        points={{-39,30},{-30,30},{-30,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseDriveTrain.tau, directPendulum.tau) annotation (Line(
        points={{1,22},{18,22}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(directPendulum.a, inverseDriveTrain.a) annotation (Line(
        points={{19,27},{9.5,27},{9.5,27},{2,27}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(directPendulum.w, inverseDriveTrain.w) annotation (Line(
        points={{19,33},{9.5,33},{9.5,33},{2,33}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(directPendulum.phi, inverseDriveTrain.phi) annotation (Line(
        points={{19,38},{11.5,38},{11.5,38},{2,38}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=5));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.InverseDriveTrain inverseDriveTrain(J=0.05)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=1, amplitude=0.5)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    FMUModels.DirectPendulum directPendulum
      annotation (Placement(transformation(extent={{40,20},{20,40}})));
  equation
    connect(sine.y, inverseDriveTrain.driveTorque) annotation (Line(
        points={{-39,30},{-30,30},{-30,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseDriveTrain.tau, directPendulum.tau) annotation (Line(
        points={{1,22},{18,22}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(directPendulum.a, inverseDriveTrain.a) annotation (Line(
        points={{19,27},{9.5,27},{9.5,27},{2,27}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(directPendulum.w, inverseDriveTrain.w) annotation (Line(
        points={{19,33},{9.5,33},{9.5,33},{2,33}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(directPendulum.phi, inverseDriveTrain.phi) annotation (Line(
        points={{19,38},{11.5,38},{11.5,38},{2,38}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=5));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model DirectPendulum "Input/output block of a direct pendulum model"
      extends Modelica.Blocks.Interfaces.BlockIcon;

      Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
        "Inertia moves with angle phi due to torque tau"
        annotation (Placement(transformation(extent={{100,70},{120,90}})));
      Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
        "Inertia moves with speed w due to torque tau"
        annotation (Placement(transformation(extent={{100,20},{120,40}})));
      Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
        "Inertia moves with angular acceleration a due to torque tau"
        annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
      Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
        "Torque to drive the inertia"
        annotation (Placement(transformation(extent={{140,-100},{100,-60}})));
      inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}},
              rotation=0)));
      Modelica.Mechanics.MultiBody.Joints.Revolute rev(
        n={0,0,1},
        useAxisFlange=true,
        phi(fixed=true),
        w(fixed=true)) annotation (Placement(transformation(extent={{-20,-20},{
                0,0}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Parts.Body body(m=1.0, r_CM={0.5,0,0})
        annotation (Placement(transformation(extent={{20,-20},{40,0}},rotation=
                0)));
      Utilities.RotFlangeToPhi rotFlangeToPhi annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,14})));
    equation

      connect(world.frame_b, rev.frame_a) annotation (Line(
          points={{-40,-10},{-20,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(body.frame_a, rev.frame_b) annotation (Line(
          points={{20,-10},{0,-10}},
          color={95,95,95},
          thickness=0.5));
      connect(rotFlangeToPhi.flange, rev.axis) annotation (Line(
          points={{-10,12},{-10,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(tau, rotFlangeToPhi.tau) annotation (Line(
          points={{120,-80},{60,-80},{60,32},{-2,32},{-2,18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToPhi.a, a) annotation (Line(
          points={{-7,17},{-7,40},{68,40},{68,-30},{110,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToPhi.w, w) annotation (Line(
          points={{-13,17},{-13,56},{76,56},{76,30},{110,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToPhi.phi, phi) annotation (Line(
          points={{-18,17},{-18,80},{110,80}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Bitmap(extent={{-92,74},{56,-46}}, fileName=
              "modelica://FMITest/Resources/Images/DirectPendulum.png"),Text(
                  extent={{-84,-58},{24,-90}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Text(
                  extent={{26,96},{110,66}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="phi"),Text(
                  extent={{28,-60},{112,-90}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="tau"),Text(
                  extent={{28,46},{112,16}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="w"),Text(
                  extent={{24,-10},{108,-40}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="a")}));
    end DirectPendulum;

    model InverseDriveTrain
      "Input/output block of an inverse drive train model"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Modelica.SIunits.Inertia J = 1 "Moment of inertia";
      Utilities.RotFlangeToTau rotFlangeToTau
        annotation (Placement(transformation(extent={{58,-10},{38,10}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
        "Angle to drive the inertia"
        annotation (Placement(transformation(extent={{140,60},{100,100}})));
      Modelica.Blocks.Interfaces.RealInput w(unit="rad/s")
        "Speed to drive the inertia"
        annotation (Placement(transformation(extent={{140,10},{100,50}})));
      Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2")
        "Angular acceleration to drive the inertia"
        annotation (Placement(transformation(extent={{140,-50},{100,-10}})));
      Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
        "Torque needed to drive the inertia according to phi, w, a"
        annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
        annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
      Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
         Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-24,-20})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(
        phi(start=0),
        w(start=0),
        J=0.05)
        annotation (Placement(transformation(extent={{18,-10},{38,10}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{-56,-46},{-36,-26}})));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear(useSupport=
            true, ratio=3)
        annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
      Modelica.Blocks.Interfaces.RealInput driveTorque
        "Torque driving the drive train"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation

      connect(fixed.flange, torque.support) annotation (Line(
          points={{-46,-36},{-46,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed.flange, damper.flange_b) annotation (Line(
          points={{-46,-36},{-24,-36},{-24,-30}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(fixed.flange, idealGear.support) annotation (Line(
          points={{-46,-36},{-2,-36},{-2,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(damper.flange_a, idealGear.flange_a) annotation (Line(
          points={{-24,-10},{-24,0},{-12,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.flange, idealGear.flange_a) annotation (Line(
          points={{-36,0},{-12,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(idealGear.flange_b, inertia.flange_a) annotation (Line(
          points={{8,0},{18,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(rotFlangeToTau.flange, inertia.flange_b) annotation (Line(
          points={{46,0},{38,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(phi, rotFlangeToTau.phi) annotation (Line(
          points={{120,80},{80,80},{80,8},{52,8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(w, rotFlangeToTau.w) annotation (Line(
          points={{120,30},{102,30},{102,28},{84,28},{84,2},{52,2},{52,2.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(a, rotFlangeToTau.a) annotation (Line(
          points={{120,-30},{86,-30},{86,-3.2},{52,-3.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToTau.tau, tau) annotation (Line(
          points={{51,-8},{80,-8},{80,-80},{110,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.tau, driveTorque) annotation (Line(
          points={{-58,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-92,-62},{4,-94}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Text(
                  extent={{-150,-110},{150,-140}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="J=%J"),Text(
                  extent={{4,-60},{88,-90}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Right,
                  textString="tau"),Bitmap(extent={{-98,102},{62,2}}, fileName=
              "modelica://FMITest/Resources/Images/InverseDriveTrain.png"),Text(
                  extent={{6,96},{90,66}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="phi",
                  horizontalAlignment=TextAlignment.Right),Text(
                  extent={{8,48},{92,18}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="w",
                  horizontalAlignment=TextAlignment.Right),Text(
                  extent={{6,-10},{90,-40}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="a",
                  horizontalAlignment=TextAlignment.Right),Text(
                  extent={{-90,-4},{38,-24}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="driveTorque",
                  horizontalAlignment=TextAlignment.Left)}));
    end InverseDriveTrain;
  end FMUModels;
  annotation (preferredView="Info");
end InertiaAndRevolute;
