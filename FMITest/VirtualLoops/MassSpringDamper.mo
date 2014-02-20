within FMITest.VirtualLoops;
package MassSpringDamper
  "Spring damper system with a mass that leads to an artificial loop with FMUs (one FMU is the mass, the other the force element)"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Mass m=0.005 "Mass of body connected to spring";
    parameter Modelica.SIunits.Position x0=2
      "Initial position of mass over ground";

    parameter Modelica.SIunits.TranslationalSpringConstant c=1
      "Stiffness of serial spring";
    parameter Modelica.SIunits.TranslationalDampingConstant d=0.1
      "Damping facgtor of serial spring";
    parameter Modelica.SIunits.Position y0=1.5
      "Initial length of serial spring";
    Modelica.SIunits.Position x
      "Position at connection point of spring-damper system";
    Modelica.SIunits.Velocity v
      "Velocity at connection point of spring-damper system";
    Modelica.SIunits.Force F
      "Cut-Force at connection point of spring-damper system";
    Modelica.SIunits.Position y "Length of serial spring";

    Modelica.Mechanics.Translational.Components.Fixed fixed
      annotation (Placement(transformation(extent={{-20,-72},{0,-52}})));
    Modelica.Mechanics.Translational.Components.Spring spring(
      c=c,
      s_rel0=y0,
      s_rel(fixed=true, start=y0)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-10,-42})));
    Modelica.Mechanics.Translational.Components.Damper damper(d=d) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-10,-10})));
    Modelica.Mechanics.Translational.Components.Mass mass(
      m=m,
      s(fixed=true, start=x0),
      v(fixed=true, start=0)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-10,26})));
    Modelica.Mechanics.Translational.Sources.Force force annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-10,56})));
    Modelica.Blocks.Sources.RealExpression gravity(y=-m*9.81*x)
      annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  equation
    x = damper.flange_b.s;
    v = der(x);
    F = damper.flange_b.f;
    y = spring.flange_b.s;
    connect(spring.flange_a, fixed.flange) annotation (Line(
        points={{-10,-52},{-10,-62}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(spring.flange_b, damper.flange_a) annotation (Line(
        points={{-10,-32},{-10,-20}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mass.flange_a, damper.flange_b) annotation (Line(
        points={{-10,16},{-10,0}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(force.flange, mass.flange_b) annotation (Line(
        points={{-10,46},{-10,36}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(gravity.y, force.f) annotation (Line(
        points={{-29,80},{-10,80},{-10,68}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    FMUModels.SpringDamper springDamper
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    FMUModels.MassWithGravity massWithGravity
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  equation
    connect(massWithGravity.x, springDamper.x) annotation (Line(
        points={{-19,16},{-2,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(massWithGravity.v, springDamper.v) annotation (Line(
        points={{-19,10},{-2,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(springDamper.f, massWithGravity.f) annotation (Line(
        points={{-1,4},{-18,4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    FMUModels.SpringDamper springDamper
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    FMUModels.MassWithGravity massWithGravity
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  equation
    connect(massWithGravity.x, springDamper.x) annotation (Line(
        points={{-19,16},{-2,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(massWithGravity.v, springDamper.v) annotation (Line(
        points={{-19,10},{-2,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(springDamper.f, massWithGravity.f) annotation (Line(
        points={{-1,4},{-18,4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model SpringDamper
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Modelica.SIunits.TranslationalSpringConstant c=1
        "Stiffness of serial spring";
      parameter Modelica.SIunits.TranslationalDampingConstant d=0.1
        "Damping facgtor of serial spring";
      parameter Modelica.SIunits.Position y0=1.5
        "Initial length of serial spring";

      Modelica.Mechanics.Translational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
      Modelica.Mechanics.Translational.Components.Spring spring(
        c=c,
        s_rel0=y0,
        s_rel(fixed=true, start=y0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-14})));
      Modelica.Mechanics.Translational.Components.Damper damper(d=d)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,18})));
      Utilities.TransFlangeToF flangeToF(enable_a=false)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      Modelica.Blocks.Interfaces.RealInput x
        "Position at connection point of spring-damper systeme"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput v
        "Velocity at connection point of spring-damper system"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput f
        "Cut-Force at connection point of spring-damper system"
        annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
      Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor
        annotation (Placement(transformation(extent={{42,-10},{62,10}})));
      Modelica.Blocks.Interfaces.RealOutput y "Length of serial spring"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      connect(spring.flange_a, fixed.flange) annotation (Line(
          points={{0,-24},{0,-34}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(spring.flange_b, damper.flange_a) annotation (Line(
          points={{0,-4},{0,8}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(flangeToF.flange, damper.flange_b) annotation (Line(
          points={{-60,0},{-40,0},{-40,38},{0,38},{0,28}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(flangeToF.s, x) annotation (Line(
          points={{-66,8},{-84,8},{-84,60},{-120,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(v, flangeToF.v) annotation (Line(
          points={{-120,0},{-80,0},{-80,2.8},{-66,2.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToF.f, f) annotation (Line(
          points={{-65,-8},{-82,-8},{-82,-60},{-110,-60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(spring.flange_b, positionSensor.flange) annotation (Line(
          points={{6.66134e-016,-4},{22,-4},{22,0},{42,0}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(positionSensor.s, y) annotation (Line(
          points={{63,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-88,78},{-26,46}},
                  lineColor={0,0,0},
                  textString="x",
                  horizontalAlignment=TextAlignment.Left),Text(
                  extent={{-86,18},{-24,-14}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Left,
                  textString="v"),Text(
                  extent={{-84,-42},{-22,-74}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Left,
                  textString="f"),Text(
                  extent={{18,18},{86,-12}},
                  lineColor={0,0,0},
                  textString="y",
                  horizontalAlignment=TextAlignment.Right),Bitmap(extent={{-62,
              98},{64,-84}}, fileName=
              "modelica://FMITest/Resources/Images/SpringDamper.png"),Text(
                  extent={{-38,-62},{70,-94}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end SpringDamper;

    model MassWithGravity
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Modelica.SIunits.Mass m=0.005
        "Mass of body connected to spring";
      parameter Modelica.SIunits.Position x0=2
        "Initial position of mass over ground";

      Modelica.Mechanics.Translational.Components.Mass mass(
        m=m,
        s(fixed=true, start=x0),
        v(fixed=true, start=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,20})));
      Modelica.Mechanics.Translational.Sources.Force force annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,50})));
      Modelica.Blocks.Sources.RealExpression gravity(y=-m*9.81*x)
        annotation (Placement(transformation(extent={{-40,64},{-20,84}})));
      Utilities.TransFlangeToS flangeToS(enable_a=false)
        annotation (Placement(transformation(extent={{14,-10},{34,10}})));
      Modelica.Blocks.Interfaces.RealOutput x
        "Flange moves with position s due to force f"
        annotation (Placement(transformation(extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.RealOutput v
        "Flange moves with speed v due to force f"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealInput f "Force to drive the flange"
        annotation (Placement(transformation(extent={{140,-80},{100,-40}})));
    equation
      connect(force.flange, mass.flange_b) annotation (Line(
          points={{0,40},{0,30}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(gravity.y, force.f) annotation (Line(
          points={{-19,74},{0,74},{0,62}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToS.flange, mass.flange_a) annotation (Line(
          points={{22,0},{0,0},{0,10}},
          color={0,127,0},
          smooth=Smooth.None));
      connect(flangeToS.s, x) annotation (Line(
          points={{27,8},{76,8},{76,60},{110,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToS.v, v) annotation (Line(
          points={{27,3},{76,3},{76,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flangeToS.f, f) annotation (Line(
          points={{28,-8},{76,-8},{76,-60},{120,-60}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{22,78},{84,46}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Right,
                  textString="x"),Text(
                  extent={{22,18},{84,-14}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Right,
                  textString="v"),Text(
                  extent={{18,-42},{80,-74}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Right,
                  textString="f"),Bitmap(extent={{-92,94},{54,-66}}, fileName=
              "modelica://FMITest/Resources/Images/MassWithGravity.png"),Text(
                  extent={{-90,-64},{18,-96}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end MassWithGravity;
  end FMUModels;
  annotation (Documentation(info="<html>
<p>
The Spring-Damper part of this model was proposed by SIMPACK AG
as a test example for an FMU.
</p>
</html>"), preferredView="Info");
end MassSpringDamper;
