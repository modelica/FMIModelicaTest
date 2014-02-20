within FMITest.SimpleConnections;
package Series3
  "Simple series connection of two FMUs consisting of all basic data types (Real, Integer, Boolean) that are propagated"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Math.Gain gain1(k=2)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Math.Gain gain2(k=3)
      annotation (Placement(transformation(extent={{20,20},{40,40}})));
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0, 1; 0.2, 3; 0.4,
          5; 0.6, 0; 0.8, 2; 0.9, 4])
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Blocks.MathInteger.Sum sum1(nu=1, k={2})
      annotation (Placement(transformation(extent={{-16,-16},{-4,-4}})));
    Modelica.Blocks.MathInteger.Sum sum2(nu=1, k={-1})
      annotation (Placement(transformation(extent={{24,-16},{36,-4}})));
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.3)
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    Modelica.Blocks.Logical.Not not2
      annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  equation
    connect(sine.y, gain1.u) annotation (Line(
        points={{-39,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain1.y, gain2.u) annotation (Line(
        points={{1,30},{18,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integerTable.y, sum1.u[1]) annotation (Line(
        points={{-39,-10},{-16,-10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(sum1.y, sum2.u[1]) annotation (Line(
        points={{-3.1,-10},{24,-10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(booleanPulse.y, not1.u) annotation (Line(
        points={{-39,-50},{-22,-50}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, not2.u) annotation (Line(
        points={{1,-50},{18,-50}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0, 1; 0.2, 3; 0.4,
          5; 0.6, 0; 0.8, 2; 0.9, 4])
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.3)
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    FMUModels.DifferentTypes1 block1
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    FMUModels.DifferentTypes2 block2
      annotation (Placement(transformation(extent={{40,0},{60,20}})));
  equation
    connect(sine.y, block1.u1) annotation (Line(
        points={{-39,50},{-20,50},{-20,16},{-2,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integerTable.y, block1.u2) annotation (Line(
        points={{-39,10},{-2,10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(booleanPulse.y, block1.u3) annotation (Line(
        points={{-39,-30},{-20,-30},{-20,4},{-2,4}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(block1.y1, block2.u1) annotation (Line(
        points={{21,16},{38,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(block1.y2, block2.u2) annotation (Line(
        points={{21,10},{38,10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(block1.y3, block2.u3) annotation (Line(
        points={{21,4},{38,4}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0, 1; 0.2, 3; 0.4,
          5; 0.6, 0; 0.8, 2; 0.9, 4])
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.3)
      annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    FMUModels.DifferentTypes1 block1
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    FMUModels.DifferentTypes2 block2
      annotation (Placement(transformation(extent={{40,0},{60,20}})));
  equation
    connect(sine.y, block1.u1) annotation (Line(
        points={{-39,50},{-20,50},{-20,16},{-2,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integerTable.y, block1.u2) annotation (Line(
        points={{-39,10},{-2,10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(booleanPulse.y, block1.u3) annotation (Line(
        points={{-39,-30},{-20,-30},{-20,4},{-2,4}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(block1.y1, block2.u1) annotation (Line(
        points={{21,16},{38,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(block1.y2, block2.u2) annotation (Line(
        points={{21,10},{38,10}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(block1.y3, block2.u3) annotation (Line(
        points={{21,4},{38,4}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model DifferentTypes1
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Math.Gain gain1(k=2)
        annotation (Placement(transformation(extent={{-20,50},{0,70}})));
      Modelica.Blocks.MathInteger.Sum sum1(k={2}, nu=1)
        annotation (Placement(transformation(extent={{-16,-6},{-4,6}})));
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
      Modelica.Blocks.Interfaces.RealInput u1 "Input signal connector"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.BooleanInput u3
        "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealOutput y1 "Output signal connector"
        annotation (Placement(transformation(extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.IntegerOutput y2 "Integer output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.BooleanOutput y3
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      Modelica.Blocks.Interfaces.IntegerInput u2
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      connect(gain1.u, u1) annotation (Line(
          points={{-22,60},{-120,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(not1.u, u3) annotation (Line(
          points={{-22,-60},{-120,-60}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(gain1.y, y1) annotation (Line(
          points={{1,60},{110,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sum1.y, y2) annotation (Line(
          points={{-3.1,0},{110,0}},
          color={255,127,0},
          smooth=Smooth.None));
      connect(not1.y, y3) annotation (Line(
          points={{1,-60},{110,-60}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(u2, sum1.u[1]) annotation (Line(
          points={{-120,0},{-16,0}},
          color={255,127,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-48,-68},{60,-100}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Bitmap(extent={{-90,96},{92,-68}},
              fileName=
              "modelica://FMITest/Resources/Images/DifferentTypes1.png")}));
    end DifferentTypes1;

    model DifferentTypes2
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Interfaces.RealInput u1 "Input signal connector"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.BooleanInput u3
        "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Interfaces.RealOutput y1 "Output signal connector"
        annotation (Placement(transformation(extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.IntegerOutput y2 "Integer output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.BooleanOutput y3
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      Modelica.Blocks.Interfaces.IntegerInput u2
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Math.Gain gain2(k=3)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.MathInteger.Sum sum2(k={-1}, nu=1)
        annotation (Placement(transformation(extent={{-16,-6},{-4,6}})));
      Modelica.Blocks.Logical.Not not2
        annotation (Placement(transformation(extent={{-20,-38},{0,-18}})));
    equation
      connect(gain2.u, u1) annotation (Line(
          points={{-22,30},{-64,30},{-64,60},{-120,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(u2, sum2.u[1]) annotation (Line(
          points={{-120,0},{-16,0}},
          color={255,127,0},
          smooth=Smooth.None));
      connect(u3, not2.u) annotation (Line(
          points={{-120,-60},{-72,-60},{-72,-28},{-22,-28}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(gain2.y, y1) annotation (Line(
          points={{1,30},{56,30},{56,60},{110,60}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sum2.y, y2) annotation (Line(
          points={{-3.1,0},{110,0}},
          color={255,127,0},
          smooth=Smooth.None));
      connect(not2.y, y3) annotation (Line(
          points={{1,-28},{56,-28},{56,-60},{110,-60}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
                  extent={{-48,-66},{60,-98}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Bitmap(extent={{-92,92},{98,-60}},
              fileName=
              "modelica://FMITest/Resources/Images/DifferentTypes2.png")}));
    end DifferentTypes2;
  end FMUModels;
  annotation (preferredView="Info");
end Series3;
