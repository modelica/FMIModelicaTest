within FMITest.VirtualLoops;
// CP: 65001
// SimulationX Version: 3.5.707.3


package InternalState
  "Integer counter that is connected in such a way that there is an artificial loop and fmiGetXXX must be called in such a way that this is consistent to the internal discrete state update"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    FMUModels.Counter counter
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression2(y=integer(time))
      annotation (Placement(transformation(extent={{-60,-8},{-40,12}})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression1(y=integer(time))
      annotation (Placement(transformation(extent={{-60,11},{-40,31}})));
  equation
    connect(integerExpression1.y, counter.u1) annotation (Line(
        points={{-39,21},{-32,21},{-32,16},{-22,16}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(integerExpression2.y, counter.u2) annotation (Line(
        points={{-39,2},{-32,2},{-32,10},{-22,10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(counter.y1, counter.u3) annotation (Line(
        points={{1,16},{16,16},{16,-12},{-28,-12},{-28,4},{-22,4}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=3));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    FMUModels.Counter counter
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression2(y=integer(time))
      annotation (Placement(transformation(extent={{-60,-8},{-40,12}})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression1(y=integer(time))
      annotation (Placement(transformation(extent={{-60,11},{-40,31}})));
  equation
    connect(integerExpression1.y, counter.u1) annotation (Line(
        points={{-39,21},{-32,21},{-32,16},{-22,16}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(integerExpression2.y, counter.u2) annotation (Line(
        points={{-39,2},{-32,2},{-32,10},{-22,10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(counter.y1, counter.u3) annotation (Line(
        points={{1,16},{16,16},{16,-12},{-28,-12},{-28,4},{-22,4}},
        color={255,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model Counter "counter"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      input Modelica.Blocks.Interfaces.IntegerInput u1
        "'input Integer' as connector" annotation (Placement(transformation(
              extent={{-140,40},{-100,80}}), iconTransformation(extent={{-140,
                40},{-100,80}})));
      input Modelica.Blocks.Interfaces.IntegerInput u2(start=0, fixed=true)
        "'input Integer' as connector" annotation (Placement(transformation(
              extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,
                -20},{-100,20}})));
      input Modelica.Blocks.Interfaces.IntegerInput u3
        "'input Integer' as connector" annotation (Placement(transformation(
              extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-140,
                -80},{-100,-40}})));
      output Modelica.Blocks.Interfaces.IntegerOutput y1
        "'output Integer' as connector" annotation (Placement(transformation(
              extent={{102,48},{122,68}}), iconTransformation(extent={{100,50},
                {120,70}})));
      output Modelica.Blocks.Interfaces.IntegerOutput y2(start=0)
        "'output Integer' as connector" annotation (Placement(transformation(
              extent={{100,-70},{120,-50}}), iconTransformation(extent={{100,-70},
                {120,-50}})));
      Integer z(start=0, fixed=true) "counter";
    equation
      when change(u2) then
        z = pre(z) + 1;
      end when;

      y1 = pre(z)*u1;
      //y1=z*u1;

      when u3 == 2 then
        y2 = 1;
      end when;
      annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
              preserveAspectRatio=false), graphics={
            Text(
              extent={{-76,-58},{80,-86}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"),
            Text(
              extent={{-92,74},{-42,48}},
              lineColor={0,0,0},
              textString="u1",
              horizontalAlignment=TextAlignment.Left),
            Text(
              extent={{-92,14},{-42,-12}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              textString="u2"),
            Text(
              extent={{-90,-46},{-40,-72}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              textString="u3"),
            Text(
              extent={{42,72},{92,46}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Right,
              textString="y1"),
            Text(
              extent={{40,-48},{90,-74}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Right,
              textString="y2")}), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-100,-100},{100,100}}), graphics));
    end Counter;
  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
The solution computed in SimulationX:
</p>
<p>
<img src=\"modelica://FMITest/Resources/Images/InternalState_Result.png\">
</p>
</html>"));
end InternalState;
