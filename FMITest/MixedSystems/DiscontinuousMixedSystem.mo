within FMITest.MixedSystems;
package DiscontinuousMixedSystem
  "Two inertias coupled with an idealized gear with efficiency leading to a mixed system of equations where the equations are discontinuous at an event"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Internal.GearWithBadEfficiency GearWithBadEfficiency(ratio=2, eta=0.5)
      annotation (Placement(transformation(extent={{14,0},{34,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(
      phi(start=0, fixed=true),
      w(start=0, fixed=true),
      J=1.1) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia2(
      J=2.2,
      phi(start=0, fixed=false),
      w(start=0, fixed=false))
      annotation (Placement(transformation(extent={{48,0},{68,20}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=2, amplitude=10)
      annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
  equation

    connect(torque.flange, inertia1.flange_a) annotation (Line(
        points={{-32,10},{-20,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(sine.y, torque.tau) annotation (Line(
        points={{-71,10},{-54,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertia1.flange_b, GearWithBadEfficiency.flange_a) annotation (Line(
        points={{0,10},{14,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(GearWithBadEfficiency.flange_b, inertia2.flange_a) annotation (Line(
        points={{34,10},{48,10}},
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

    FMUModels.InertiaGear inertiaGear
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.InverseInertia inverseInertia
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=2, amplitude=10)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(inertiaGear.phi, inverseInertia.phi) annotation (Line(
        points={{1,18},{18,18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertiaGear.w, inverseInertia.w) annotation (Line(
        points={{1,13},{18,13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertiaGear.a, inverseInertia.a) annotation (Line(
        points={{1,7},{18,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseInertia.tau, inertiaGear.tau) annotation (Line(
        points={{19,2},{2,2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine.y, inertiaGear.tauDrive) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.InertiaGear inertiaGear
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.InverseInertia inverseInertia
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Blocks.Sources.Sine sine(freqHz=2, amplitude=10)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(inertiaGear.phi, inverseInertia.phi) annotation (Line(
        points={{1,18},{18,18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertiaGear.w, inverseInertia.w) annotation (Line(
        points={{1,13},{18,13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inertiaGear.a, inverseInertia.a) annotation (Line(
        points={{1,7},{18,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseInertia.tau, inertiaGear.tau) annotation (Line(
        points={{19,2},{2,2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine.y, inertiaGear.tauDrive) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model InertiaGear "Input/output block of an inertia with a gear"
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
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
      Internal.GearWithBadEfficiency GearWithBadEfficiency(ratio=2, eta=0.5)
        annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
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
      connect(torque.tau, tauDrive) annotation (Line(
          points={{-84,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.flange, inertia1.flange_a) annotation (Line(
          points={{-62,0},{-50,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia1.flange_b, GearWithBadEfficiency.flange_a) annotation (
          Line(
          points={{-30,0},{-18,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(GearWithBadEfficiency.flange_b, flangeToPhi.flange) annotation (
          Line(
          points={{2,0},{14,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-84,-58},{24,-90}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Text(
                  extent={{8,96},{92,66}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  textString="phi",
                  horizontalAlignment=TextAlignment.Right),Text(
                  extent={{10,46},{94,16}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Right,
                  textString="w"),Text(
                  extent={{6,-10},{90,-40}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Right,
                  textString="a"),Text(
                  extent={{10,-60},{94,-90}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Right,
                  textString="tau"),Bitmap(extent={{-88,58},{72,-28}}, fileName
              ="modelica://FMITest/Resources/Images/InertiaGear.png")}));
    end InertiaGear;

    model InverseInertia "Input/output block of an inverse inertia"
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
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=2.2)
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
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
      connect(rotFlangeToTau.flange, inertia2.flange_a) annotation (Line(
          points={{-24,0},{0,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{0,-62},{96,-94}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Text(
                  extent={{-94,96},{-10,66}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Left,
                  textString="phi"),Text(
                  extent={{-94,46},{-10,16}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Left,
                  textString="w"),Text(
                  extent={{-92,-14},{-8,-44}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Left,
                  textString="a"),Text(
                  extent={{-90,-64},{-6,-94}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={245,245,245},
                  horizontalAlignment=TextAlignment.Left,
                  textString="tau"),Bitmap(extent={{-66,56},{96,-28}}, fileName
              ="modelica://FMITest/Resources/Images/InverseInertia2.png")}));
    end InverseInertia;
  end FMUModels;

  package Internal "Utility models needed in this test model"
    extends Modelica.Icons.Package;

    model GearWithBadEfficiency
      "Model of a gear with gear efficiency that has bad numeric properties (do not model gear efficiency in this way!)"

      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      parameter Real ratio=1 "Gear ratio";
      parameter Real eta(
        min=0.0,
        max=1.0) = 1.0 "Effciency of gear box";
      Modelica.SIunits.Power power;
      Real eff;
    equation
      flange_a.phi = ratio*flange_b.phi;
      power = flange_b.tau*der(flange_b.phi);
      eff = if power > 0 then eta else 1/eta;
      0 = ratio*flange_a.tau + eff*flange_b.tau;
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,10},{-40,-10}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Rectangle(
                  extent={{-40,20},{-20,-20}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Rectangle(
                  extent={{-20,70},{20,50}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Rectangle(
                  extent={{-40,100},{-20,20}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Rectangle(
                  extent={{20,80},{40,39}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Rectangle(
                  extent={{20,40},{40,-40}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Rectangle(
                  extent={{40,10},{100,-10}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={192,192,192}),Line(points={{60,20},{80,20}}, color
              ={0,0,0}),Line(points={{70,-20},{70,-86}}, color={0,0,0}),Line(
              points={{60,-20},{80,-20}}, color={0,0,0}),Line(points={{0,40},{0,
              -86}}, color={0,0,0}),Line(points={{-10,40},{10,40}}, color={0,0,
              0}),Line(points={{-10,80},{10,80}}, color={0,0,0}),Line(points={{
              -80,-20},{-60,-20}}, color={0,0,0}),Line(points={{-70,-20},{-70,-86}},
              color={0,0,0}),Text(
                  extent={{-147,-111},{153,-141}},
                  lineColor={0,0,0},
                  textString="ratio=%ratio"),Line(points={{70,-86},{-70,-86}},
              color={0,0,0}),Line(
                  visible=not useSupport,
                  points={{-48,-106},{-28,-86}},
                  color={0,0,0}),Line(
                  visible=not useSupport,
                  points={{-28,-86},{32,-86}},
                  color={0,0,0}),Line(
                  visible=not useSupport,
                  points={{-28,-106},{-8,-86}},
                  color={0,0,0}),Line(
                  visible=not useSupport,
                  points={{-8,-106},{12,-86}},
                  color={0,0,0}),Line(
                  visible=not useSupport,
                  points={{12,-106},{32,-86}},
                  color={0,0,0}),Polygon(
                  points={{-109,40},{-80,40},{-80,80},{-90,80},{-70,100},{-50,
                80},{-60,80},{-60,20},{-109,20},{-109,40}},
                  lineColor={0,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-148,145},{152,105}},
                  lineColor={0,0,255},
                  textString="%name"),Text(
                  extent={{-149,-147},{151,-177}},
                  lineColor={0,0,0},
                  textString="eta=%eta")}));
    end GearWithBadEfficiency;
  end Internal;
  annotation (preferredView="Info");
end DiscontinuousMixedSystem;
