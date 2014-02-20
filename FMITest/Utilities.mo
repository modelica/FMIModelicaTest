within FMITest;
package Utilities "Utility models used by the component models"
  extends Modelica.Icons.Package;
  package Icons "Additional icons used in package FMITest"
    extends Modelica.Icons.Package;

    partial model PartialElectricalAdaptorIcon
      "Basic graphical layout of an adaptor block from a physical to input/output connectors"

      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0.04), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-200,200},{200,120}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            initialScale=0.04)),
        Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
Boolean block (no declarations, no equations) used especially
in the Blocks.Logical library.
</p>
</html>"));
    end PartialElectricalAdaptorIcon;

    model PartialMechanicalAdaptorIcon
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Rectangle(
              extent={{-20,100},{20,-100}},
              lineColor={0,0,0},
              fillColor={245,245,245},
              fillPattern=FillPattern.HorizontalCylinder), Text(
              extent={{-150,150},{150,110}},
              lineColor={0,0,255},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="%name")}));
    end PartialMechanicalAdaptorIcon;
  end Icons;

  model PinToI "Adaptor for a pin with voltage as input and current as output"
    extends FMITest.Utilities.Icons.PartialElectricalAdaptorIcon;
    Modelica.Electrical.Analog.Interfaces.Pin pin
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealInput v(unit="V")
      "Potential at the pin as provided from the outside"
      annotation (Placement(transformation(extent={{180,10},{100,90}})));
    Modelica.Blocks.Interfaces.RealOutput i(unit="A")
      "Current flowing in to the pin as provided to the outside"
      annotation (Placement(transformation(extent={{100,-70},{140,-30}})));
  equation
    pin.v = v;
    i = -pin.i;

    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1},
          initialScale=0.04), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1},
          initialScale=0.04), graphics={Text(
            extent={{-12,88},{82,42}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="v",
            horizontalAlignment=TextAlignment.Right), Text(
            extent={{-24,-36},{74,-82}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Right,
            textString="i")}));
  end PinToI;

  model PinToV "Adaptor for a pin with current as input and voltage as output"
    extends FMITest.Utilities.Icons.PartialElectricalAdaptorIcon;
    Modelica.Electrical.Analog.Interfaces.NegativePin pin
      annotation (Placement(transformation(extent={{-80,-20},{-120,20}})));
    Modelica.Blocks.Interfaces.RealInput i(unit="A")
      "Current flowing in to the pin as provided from the outside"
      annotation (Placement(transformation(extent={{180,-90},{100,-10}})));
    Modelica.Blocks.Interfaces.RealOutput v(unit="V")
      "Potential at the pin as provided to the outside"
      annotation (Placement(transformation(extent={{100,30},{140,70}})));
  equation
    pin.i = i;
    v = pin.v;

    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          initialScale=0.04,
          grid={1,1}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          initialScale=0.04,
          grid={1,1}), graphics={Text(
            extent={{-8,82},{80,36}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Right,
            textString="v"), Text(
            extent={{-20,-34},{84,-80}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Right,
            textString="i")}));
  end PinToV;

  model RotFlangeToPhi
    "Adaptor for a Rotational flange with angle, speed, and acceleration as outputs"
    extends FMITest.Utilities.Icons.PartialMechanicalAdaptorIcon;
    parameter Boolean enable_a=true "Enable the output connector a" annotation
      (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
      "Flange moves with angle phi due to torque tau"
      annotation (Placement(transformation(extent={{20,70},{40,90}})));
    Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
      "Flange moves with speed w due to torque tau"
      annotation (Placement(transformation(extent={{20,20},{40,40}})));

    Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2") if enable_a
      "Flange moves with angular acceleration a due to torque tau"
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
      "Torque to drive the flange"
      annotation (Placement(transformation(extent={{60,-100},{20,-60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput a_internal
      "Needed to connect to conditional connector";
  equation
    connect(a, a_internal);
    if not enable_a then
      a_internal = 0.0;
    end if;
    phi = flange.phi;
    w = der(phi);
    if enable_a then
      a_internal = der(w);
    end if;
    flange.tau = tau;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Text(
            extent={{-20,92},{20,70}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="phi"),
          Text(
            extent={{-20,42},{20,20}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="w"),
          Text(
            visible=enable_a,
            extent={{-20,-18},{20,-40}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="a"),
          Text(
            extent={{-20,-68},{20,-90}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="tau")}));
  end RotFlangeToPhi;

  model RotFlangeToTau
    extends Icons.PartialMechanicalAdaptorIcon;
    parameter Boolean enable_a=true "Enable the output connector a" annotation
      (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{56,-10},{76,10}}), iconTransformation(
            extent={{10,-10},{30,10}})));
    Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
      "Angle to drive the flange" annotation (Placement(transformation(extent={
              {-80,60},{-40,100}}), iconTransformation(extent={{-60,60},{-20,
              100}})));
    Modelica.Blocks.Interfaces.RealInput w(unit="rad/s")
      "Speed to drive the flange" annotation (Placement(transformation(extent={
              {-80,10},{-40,50}}), iconTransformation(extent={{-60,8},{-20,48}})));
    Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2") if enable_a
      "Angular acceleration to drive the flange" annotation (Placement(
          transformation(extent={{-80,-50},{-40,-10}}), iconTransformation(
            extent={{-60,-52},{-20,-12}})));
    Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
      "Torque needed to drive the flange according to phi, w, a" annotation (
        Placement(transformation(extent={{-40,-90},{-60,-70}}),
          iconTransformation(extent={{-20,-90},{-40,-70}})));
    Modelica.Mechanics.Rotational.Sources.Move move
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Modelica.Blocks.Routing.Multiplex3 multiplex3
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
      annotation (Placement(transformation(extent={{36,-10},{56,10}})));

    Modelica.Blocks.Sources.Constant const(final k=0) if not enable_a
      annotation (Placement(transformation(extent={{-92,-60},{-72,-40}})));
  equation
    connect(multiplex3.y, move.u) annotation (Line(
        points={{1,0},{8,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(phi, multiplex3.u1[1]) annotation (Line(
        points={{-60,80},{-32,80},{-32,7},{-22,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(w, multiplex3.u2[1]) annotation (Line(
        points={{-60,30},{-36,30},{-36,0},{-22,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(a, multiplex3.u3[1]) annotation (Line(
        points={{-60,-30},{-32,-30},{-32,-7},{-22,-7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(flange, torqueSensor.flange_b) annotation (Line(
        points={{66,0},{56,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(move.flange, torqueSensor.flange_a) annotation (Line(
        points={{30,0},{36,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(torqueSensor.tau, tau) annotation (Line(
        points={{38,-11},{38,-80},{-50,-80}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, multiplex3.u3[1]) annotation (Line(
        points={{-71,-50},{-32,-50},{-32,-7},{-22,-7}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-20,100},{20,78}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="phi"),
          Text(
            extent={{-20,40},{20,18}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="w"),
          Text(
            visible=enable_a,
            extent={{-20,-20},{20,-42}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="a"),
          Text(
            extent={{-20,-70},{20,-92}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="tau")}), Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}), graphics));
  end RotFlangeToTau;

  model TransFlangeToS
    "Adaptor for a Translational flange with position, speed, and acceleration as outputs"
    extends FMITest.Utilities.Icons.PartialMechanicalAdaptorIcon;
    parameter Boolean enable_a=true "Enable the output connector a" annotation
      (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    Modelica.Blocks.Interfaces.RealOutput s(unit="m")
      "Flange moves with position s due to force f"
      annotation (Placement(transformation(extent={{20,70},{40,90}})));
    Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
      "Flange moves with speed v due to force f"
      annotation (Placement(transformation(extent={{20,20},{40,40}})));

    Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2") if enable_a
      "Flange moves with acceleration a due to force f"
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    Modelica.Blocks.Interfaces.RealInput f(unit="N")
      "Force to drive the flange"
      annotation (Placement(transformation(extent={{60,-100},{20,-60}})));

  protected
    Modelica.Blocks.Interfaces.RealInput a_internal
      "Needed to connect to conditional connector";
  equation
    connect(a, a_internal);
    if not enable_a then
      a_internal = 0.0;
    end if;
    s = flange.s;
    v = der(s);
    if enable_a then
      a_internal = der(v);
    end if;
    flange.f = f;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Text(
            extent={{-20,92},{20,70}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="s"),
          Text(
            extent={{-20,42},{20,20}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="v"),
          Text(
            visible=enable_a,
            extent={{-20,-18},{20,-40}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="a"),
          Text(
            extent={{-20,-68},{20,-90}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="f")}));
  end TransFlangeToS;

  model TransFlangeToF
    extends Icons.PartialMechanicalAdaptorIcon;
    parameter Boolean enable_a=true "Enable the output connector a" annotation
      (
      Evaluate=true,
      HideResult=true,
      choices(checkBox=true));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
        Placement(transformation(extent={{56,-10},{76,10}}), iconTransformation(
            extent={{10,-10},{30,10}})));
    Modelica.Blocks.Interfaces.RealInput s(unit="m")
      "Position to drive the flange" annotation (Placement(transformation(
            extent={{-80,60},{-40,100}}), iconTransformation(extent={{-60,60},{
              -20,100}})));
    Modelica.Blocks.Interfaces.RealInput v(unit="m/s")
      "Speed to drive the flange" annotation (Placement(transformation(extent={
              {-80,10},{-40,50}}), iconTransformation(extent={{-60,8},{-20,48}})));
    Modelica.Blocks.Interfaces.RealInput a(unit="m/s2") if enable_a
      "Acceleration to drive the flange" annotation (Placement(transformation(
            extent={{-80,-50},{-40,-10}}), iconTransformation(extent={{-60,-52},
              {-20,-12}})));
    Modelica.Blocks.Interfaces.RealOutput f(unit="N")
      "Force needed to drive the flange according to s, v, a" annotation (
        Placement(transformation(extent={{-40,-90},{-60,-70}}),
          iconTransformation(extent={{-20,-90},{-40,-70}})));
    Modelica.Mechanics.Translational.Sources.Move move
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Modelica.Blocks.Routing.Multiplex3 multiplex3
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor
      annotation (Placement(transformation(extent={{36,-10},{56,10}})));

    Modelica.Blocks.Sources.Constant const(final k=0) if not enable_a
      annotation (Placement(transformation(extent={{-92,-60},{-72,-40}})));
  equation
    connect(multiplex3.y, move.u) annotation (Line(
        points={{1,0},{8,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(s, multiplex3.u1[1]) annotation (Line(
        points={{-60,80},{-32,80},{-32,7},{-22,7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(v, multiplex3.u2[1]) annotation (Line(
        points={{-60,30},{-36,30},{-36,0},{-22,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(a, multiplex3.u3[1]) annotation (Line(
        points={{-60,-30},{-32,-30},{-32,-7},{-22,-7}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(flange, forceSensor.flange_b) annotation (Line(
        points={{66,0},{56,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(move.flange, forceSensor.flange_a) annotation (Line(
        points={{30,0},{36,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(forceSensor.f, f) annotation (Line(
        points={{38,-11},{38,-80},{-50,-80}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, multiplex3.u3[1]) annotation (Line(
        points={{-71,-50},{-32,-50},{-32,-7},{-22,-7}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-20,100},{20,78}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="s"),
          Text(
            extent={{-20,40},{20,18}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="v"),
          Text(
            visible=enable_a,
            extent={{-20,-20},{20,-42}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="a"),
          Text(
            extent={{-20,-70},{20,-92}},
            lineColor={0,0,0},
            fillColor={235,245,255},
            fillPattern=FillPattern.Solid,
            textString="f")}), Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{100,100}}), graphics));
  end TransFlangeToF;

  model InquireInitializationEnd
    "Modelica code to inquire when fmiCompletedInitialization has to be called in a Modelica model"
    Real x(start=1);
    Boolean first(start=true, fixed=true);
    Boolean first2;
    Modelica.Mechanics.Rotational.Examples.Friction friction
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  initial equation
    0.5 = Modelica.Math.sin(x)^2 + sqrt(x);
    first2 = true;
  equation
    der(x) = -x;
    when not initial() then
      // Call fmiCompletedInitialization here
      first = false;
      first2 = false;
    end when;
    LogVariable(first);
    LogVariable(first2);
  end InquireInitializationEnd;
end Utilities;
