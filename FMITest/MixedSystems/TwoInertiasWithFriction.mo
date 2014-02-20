within FMITest.MixedSystems;
package TwoInertiasWithFriction
  "Test of two coupled Coulomb friction elements leading to a mixed system of equations"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      J=1.1,
      phi(start=0, fixed=true),
      w(start=0, fixed=true))
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=6)
      annotation (Placement(transformation(extent={{70,18},{90,38}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=1.2, amplitude=2)
      annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction friction1(
        useSupport=false)
      annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction friction2(
        useSupport=true)
      annotation (Placement(transformation(extent={{24,18},{44,38}})));
    Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates(
      stateSelect=StateSelect.always,
      phi_rel(fixed=true),
      w_rel(fixed=true))
      annotation (Placement(transformation(extent={{42,0},{62,20}})));
  equation
    connect(sine.y, torque.tau) annotation (Line(
        points={{-71,10},{-62,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(torque.flange, friction1.flange_a) annotation (Line(
        points={{-40,10},{-30,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(friction1.flange_b, inertia1.flange_a) annotation (Line(
        points={{-10,10},{0,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia1.flange_b, friction2.support) annotation (Line(
        points={{20,10},{34,10},{34,18}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(friction2.flange_b, inertia2.flange_a) annotation (Line(
        points={{44,28},{70,28}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia1.flange_b, relativeStates.flange_a) annotation (Line(
        points={{20,10},{42,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(relativeStates.flange_b, inertia2.flange_a) annotation (Line(
        points={{62,10},{62,28},{70,28}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      experiment(StopTime=1.1),
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

    Modelica.Blocks.Sources.Sine sine(freqHz=1.2, amplitude=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    FMUModels.FrictionInertia frictionInertia
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.RelativeFrictionInertia relativeFrictionInertia
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
  equation
    connect(sine.y, frictionInertia.tauDrive) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frictionInertia.phi, relativeFrictionInertia.phi) annotation (Line(
        points={{1,18},{18,18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frictionInertia.w, relativeFrictionInertia.w) annotation (Line(
        points={{1,13},{18,13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frictionInertia.a, relativeFrictionInertia.a) annotation (Line(
        points={{1,7},{18,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(relativeFrictionInertia.tau, frictionInertia.tau) annotation (Line(
        points={{19,2},{2,2}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    Modelica.Blocks.Sources.Sine sine(freqHz=1.2, amplitude=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    FMUModels.FrictionInertia frictionInertia
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.RelativeFrictionInertia relativeFrictionInertia
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
  equation
    connect(sine.y, frictionInertia.tauDrive) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frictionInertia.phi, relativeFrictionInertia.phi) annotation (Line(
        points={{1,18},{18,18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frictionInertia.w, relativeFrictionInertia.w) annotation (Line(
        points={{1,13},{18,13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frictionInertia.a, relativeFrictionInertia.a) annotation (Line(
        points={{1,7},{18,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(relativeFrictionInertia.tau, frictionInertia.tau) annotation (Line(
        points={{19,2},{2,2}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model FrictionInertia "Input/output block of an inertia with friction"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Interfaces.RealInput tauDrive
        "Accelerating torque acting at flange (= -flange.tau)"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Utilities.RotFlangeToPhi flangeToPhi
        annotation (Placement(transformation(extent={{6,-10},{26,10}})));
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
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        J=1.1,
        phi(start=0, fixed=true),
        w(start=0, fixed=true))
        annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction friction1(
          useSupport=false)
        annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
    equation

      connect(flangeToPhi.phi, phi) annotation (Line(
          points={{19,8},{60,8},{60,80},{110,80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToPhi.w, w) annotation (Line(
          points={{19,3},{66,3},{66,30},{110,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToPhi.tau, tau) annotation (Line(
          points={{20,-8},{60,-8},{60,-80},{120,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToPhi.a, a) annotation (Line(
          points={{19,-3},{66,-3},{66,-30},{110,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.flange, friction1.flange_a) annotation (Line(
          points={{-62,0},{-52,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(friction1.flange_b, inertia1.flange_a) annotation (Line(
          points={{-32,0},{-22,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.tau, tauDrive) annotation (Line(
          points={{-84,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(inertia1.flange_b, flangeToPhi.flange) annotation (Line(
          points={{-2,0},{14,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Text(
              extent={{-84,-58},{24,-90}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"),
            Text(
              extent={{8,96},{92,66}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              textString="phi",
              horizontalAlignment=TextAlignment.Right),
            Text(
              extent={{10,46},{94,16}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Right,
              textString="w"),
            Text(
              extent={{6,-10},{90,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Right,
              textString="a"),
            Text(
              extent={{10,-60},{94,-90}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Right,
              textString="tau"),
            Bitmap(extent={{-92,76},{58,-54}}, fileName=
                  "modelica://FMITest/Resources/Images/FrictionInertia.png")}));
    end FrictionInertia;

    model RelativeFrictionInertia
      "Input/output block of inertia with friction relative to a moving support"
      extends Modelica.Blocks.Interfaces.BlockIcon;

      Utilities.RotFlangeToTau rotFlangeToTau
        annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
        "Angle to drive the inertia"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput w(unit="rad/s")
        "Speed to drive the inertia"
        annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
      Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2")
        "Angular acceleration to drive the inertia"
        annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
      Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
        "Torque needed to drive the flange according to phi, w, a"
        annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=6)
        annotation (Placement(transformation(extent={{44,14},{64,34}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction friction2(
          useSupport=true)
        annotation (Placement(transformation(extent={{-2,14},{18,34}})));
      Modelica.Mechanics.Rotational.Components.RelativeStates relativeStates(
        stateSelect=StateSelect.always,
        phi_rel(fixed=true),
        w_rel(fixed=true))
        annotation (Placement(transformation(extent={{16,-4},{36,16}})));
    equation

      connect(rotFlangeToTau.phi, phi) annotation (Line(
          points={{-30,8},{-84,8},{-84,80},{-120,80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToTau.w, w) annotation (Line(
          points={{-30,2.8},{-90,2.8},{-90,30},{-120,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToTau.a, a) annotation (Line(
          points={{-30,-3.2},{-80,-3.2},{-80,-30},{-120,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(rotFlangeToTau.tau, tau) annotation (Line(
          points={{-29,-8},{-70,-8},{-70,-80},{-110,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(friction2.flange_b, inertia2.flange_a) annotation (Line(
          points={{18,24},{44,24}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(relativeStates.flange_b, inertia2.flange_a) annotation (Line(
          points={{36,6},{36,24},{44,24}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(friction2.support, relativeStates.flange_a) annotation (Line(
          points={{8,14},{8,6},{16,6}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(rotFlangeToTau.flange, friction2.support) annotation (Line(
          points={{-24,0},{8,0},{8,14}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Text(
              extent={{0,-62},{96,-94}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"),
            Text(
              extent={{-94,96},{-10,66}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Left,
              textString="phi"),
            Text(
              extent={{-94,46},{-10,16}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Left,
              textString="w"),
            Text(
              extent={{-92,-14},{-8,-44}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Left,
              textString="a"),
            Text(
              extent={{-90,-64},{-6,-94}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              horizontalAlignment=TextAlignment.Left,
              textString="tau"),
            Bitmap(extent={{-56,58},{98,-32}}, fileName=
                  "modelica://FMITest/Resources/Images/RelativeFrictionInertia.png")}));
    end RelativeFrictionInertia;
  end FMUModels;
  annotation (preferredView="Info");
end TwoInertiasWithFriction;
