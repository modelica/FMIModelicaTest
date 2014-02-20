within FMITest.MixedSystems;
// CP: 65001
// SimulationX Version: 3.5.707.3

package DiscreteContinuousNonLinear
  "Nonlinear system of equation with discrete part that requires to lock relations at events in order that in the inner loop the real nonlinear algebraic equation system can be solved."
  extends Modelica.Icons.ExamplesPackage;
  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.ModelA modelA
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    FMUModels.ModelB modelB
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
  equation
    connect(modelA.a, modelB.a) annotation (Line(
        points={{-19,16},{-2,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(modelA.b, modelB.b) annotation (Line(
        points={{-19,10},{-2,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(modelA.c, modelB.c) annotation (Line(
        points={{-19,4},{-2,4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(modelB.m, modelA.m) annotation (Line(
        points={{21,16},{32,16},{32,32},{-52,32},{-52,16},{-42,16}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(modelB.y, modelA.u) annotation (Line(
        points={{21,4},{32,4},{32,-12},{-52,-12},{-52,4},{-42,4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
The solution computed in SimulationX:
</p>
<p>
<img src=\"modelica://FMITest/Resources/Images/DiscreteContinuousNonLinear_Result.png\">
</p>
</html>"));

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model ModelA "Nonlinear system of equations depending on discrete input"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      output Modelica.Blocks.Interfaces.RealOutput a(start=0.8) "Real output a"
        annotation (Placement(transformation(extent={{100,50},{120,70}})));
      output Modelica.Blocks.Interfaces.RealOutput b(start=-0.8)
        "Real output b"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      output Modelica.Blocks.Interfaces.RealOutput c(start=1) "Real output c"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      input Modelica.Blocks.Interfaces.IntegerInput m(start=1)
        "Integer input m"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      input Modelica.Blocks.Interfaces.RealInput u "Real input u"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      Real v(start=0, fixed=true) "Cont. state";
    equation
      der(v) = -a;
      0 = 100*sin(a/100) + 200*sin(b/200);
      if m == 0 then
        0 = v + 1 - ((2 + a)^5) + c;
      else
        0 = v + 1 - ((2 + b)^5) + c;
      end if;
      c = cos(time*u);
      annotation (
        a(flags=2),
        b(flags=2),
        c(flags=2),
        v(flags=2),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}},
              preserveAspectRatio=false), graphics={
            Text(
              extent={{-86,78},{-14,46}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="m",
              horizontalAlignment=TextAlignment.Left),
            Text(
              extent={{-86,-42},{-14,-74}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Left,
              textString="u"),
            Text(
              extent={{12,78},{84,46}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Right,
              textString="a"),
            Text(
              extent={{12,18},{84,-14}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Right,
              textString="b"),
            Text(
              extent={{12,-44},{84,-76}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Right,
              textString="c")}),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
              preserveAspectRatio=false), graphics),
        experiment(StopTime=1, StartTime=0));
    end ModelA;

    model ModelB "Discrete and continuous equations"
      extends Modelica.Blocks.Interfaces.BlockIcon;

      input Modelica.Blocks.Interfaces.RealInput a "Real input a" annotation (
          Placement(transformation(extent={{-140,40},{-100,80}}),
            iconTransformation(extent={{-140,40},{-100,80}})));
      input Modelica.Blocks.Interfaces.RealInput b "Real input b" annotation (
          Placement(transformation(extent={{-140,-20},{-100,20}}),
            iconTransformation(extent={{-140,-20},{-100,20}})));
      input Modelica.Blocks.Interfaces.RealInput c "Real input c" annotation (
          Placement(transformation(extent={{-140,-80},{-100,-40}}),
            iconTransformation(extent={{-140,-80},{-100,-40}})));
      output Modelica.Blocks.Interfaces.IntegerOutput m "Integer output m"
        annotation (Placement(transformation(extent={{100,50},{120,70}}),
            iconTransformation(extent={{100,50},{120,70}})));
      output Modelica.Blocks.Interfaces.RealOutput y "Real output y"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
            iconTransformation(extent={{100,-70},{120,-50}})));
      parameter Real switch=0.8 "Switch point";
    equation
      if ((a + b + c) < switch) then
        m = 0;
      else
        m = 1;
      end if;
      y = 2*(a + b + c);
      annotation (
        m(flags=2),
        y(flags=2),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}},
              preserveAspectRatio=false), graphics={
            Text(
              extent={{-86,76},{-32,46}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="a",
              horizontalAlignment=TextAlignment.Left),
            Text(
              extent={{-84,18},{-30,-12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Left,
              textString="b"),
            Text(
              extent={{-84,-44},{-30,-74}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Left,
              textString="c"),
            Text(
              extent={{28,78},{82,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Right,
              textString="m"),
            Text(
              extent={{26,-40},{80,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              horizontalAlignment=TextAlignment.Right,
              textString="y")}),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
              preserveAspectRatio=false), graphics),
        experiment(StopTime=1, StartTime=0));
    end ModelB;
    annotation (dateModified="2013-04-26 13:10:58Z", Icon(coordinateSystem(
            extent={{-100,-100},{100,100}})));
  end FMUModels;
end DiscreteContinuousNonLinear;
