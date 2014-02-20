within FMITest.Initialization.MixedSystems;
package InertiaWithFrictionAndSteadyState
  "Steady state initialization over a mixed system of equations (inertia with friction)"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      J=1.1,
      w(start=0, fixed=true),
      phi(start=0, fixed=false),
      a(fixed=true, start=0))
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque1
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Sources.Sine sine(
      freqHz=1.2,
      amplitude=2,
      startTime=0.5)
      annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction friction(
        useSupport=false)
      annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
    Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c=1000,
        d=10) annotation (Placement(transformation(extent={{32,0},{52,20}})));
    Modelica.Mechanics.Rotational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{60,0},{80,20}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque2
      annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
    Modelica.Blocks.Sources.Constant const(k=2.0)
      annotation (Placement(transformation(extent={{-92,34},{-72,54}})));
  equation
    connect(sine.y, torque1.tau) annotation (Line(
        points={{-71,10},{-62,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(friction.flange_a, torque1.flange) annotation (Line(
        points={{-30,10},{-40,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia.flange_a, friction.flange_b) annotation (Line(
        points={{0,10},{-10,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia.flange_b, springDamper.flange_a) annotation (Line(
        points={{20,10},{32,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(springDamper.flange_b, fixed.flange) annotation (Line(
        points={{52,10},{70,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torque2.flange, torque1.flange) annotation (Line(
        points={{-40,44},{-34,44},{-34,10},{-40,10}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(const.y, torque2.tau) annotation (Line(
        points={{-71,44},{-62,44}},
        color={0,0,127},
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

    FMUModels.FrictionInertia frictionInertia
      annotation (Placement(transformation(extent={{16,0},{36,20}})));
    Modelica.Blocks.Sources.Constant const(k=2.0)
      annotation (Placement(transformation(extent={{-60,18},{-40,38}})));
    Modelica.Blocks.Sources.Sine sine(
      freqHz=1.2,
      amplitude=2,
      startTime=0.5)
      annotation (Placement(transformation(extent={{-60,-16},{-40,4}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=2)
      annotation (Placement(transformation(extent={{-14,4},{-2,16}})));
  equation
    connect(const.y, multiSum.u[1]) annotation (Line(
        points={{-39,28},{-26,28},{-26,12.1},{-14,12.1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine.y, multiSum.u[2]) annotation (Line(
        points={{-39,-6},{-26,-6},{-26,7.9},{-14,7.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(multiSum.y, frictionInertia.tauDrive) annotation (Line(
        points={{-0.98,10},{14,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.FrictionInertia frictionInertia
      annotation (Placement(transformation(extent={{16,2},{36,22}})));
    Modelica.Blocks.Sources.Constant const(k=2.0)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.Sine sine(
      freqHz=1.2,
      amplitude=2,
      startTime=0.5)
      annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=2)
      annotation (Placement(transformation(extent={{-14,6},{-2,18}})));
  equation
    connect(const.y, multiSum.u[1]) annotation (Line(
        points={{-39,30},{-26,30},{-26,14.1},{-14,14.1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sine.y, multiSum.u[2]) annotation (Line(
        points={{-39,-4},{-26,-4},{-26,9.9},{-14,9.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(multiSum.y, frictionInertia.tauDrive) annotation (Line(
        points={{-0.98,12},{14,12}},
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
      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
      Modelica.Mechanics.Rotational.Components.BearingFriction friction(
          useSupport=false)
        annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(
        J=1.1,
        w(start=0, fixed=true),
        phi(start=0, fixed=false),
        a(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper springDamper(c=1000,
          d=10)
        annotation (Placement(transformation(extent={{28,-10},{48,10}})));
      Modelica.Mechanics.Rotational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{56,-10},{76,10}})));
    equation

      connect(inertia.flange_a, friction.flange_b) annotation (Line(
          points={{-4,0},{-14,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(inertia.flange_b, springDamper.flange_a) annotation (Line(
          points={{16,0},{28,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(springDamper.flange_b, fixed.flange) annotation (Line(
          points={{48,0},{66,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.tau, tauDrive) annotation (Line(
          points={{-66,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(torque.flange, friction.flange_a) annotation (Line(
          points={{-44,0},{-34,0}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
              extent={{-20,-60},{88,-92}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"), Bitmap(extent={{-92,64},{94,-34}}, fileName
                ="modelica://FMITest/Resources/Images/InertiaWithFrictionAndSteadyState.png")}));
    end FrictionInertia;

  end FMUModels;
  annotation (preferredView="Info");
end InertiaWithFrictionAndSteadyState;
