within FMITest.SimpleConnections;
package SeriesWithEnumerations1
  "Simple series connection of two FMUs where enumerations are propagated"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0, 1; 0.2, 3; 0.4,
          5; 0.6, 1; 0.8, 2; 0.9, 4])
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Internal.IntegerToGearSelector integerToGearSelector
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    FMUModels.SwitchGearUp switchGearUp
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
    FMUModels.SwitchGearDown switchGearDown
      annotation (Placement(transformation(extent={{40,20},{60,40}})));
  equation
    connect(integerTable.y, integerToGearSelector.u) annotation (Line(
        points={{-59,30},{-42,30}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(integerToGearSelector.y, switchGearUp.u) annotation (Line(
        points={{-19,30},{-2,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(switchGearUp.y, switchGearDown.u) annotation (Line(
        points={{21,30},{38,30}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.IntegerTable integerTable(table=[0, 1; 0.2, 3; 0.4,
          5; 0.6, 1; 0.8, 2; 0.9, 4])
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Internal.IntegerToGearSelector integerToGearSelector
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    FMUModels.SwitchGearUp switchGearUp
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
    FMUModels.SwitchGearDown switchGearDown
      annotation (Placement(transformation(extent={{40,20},{60,40}})));
  equation
    connect(integerTable.y, integerToGearSelector.u) annotation (Line(
        points={{-59,30},{-42,30}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(integerToGearSelector.y, switchGearUp.u) annotation (Line(
        points={{-19,30},{-2,30}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(switchGearUp.y, switchGearDown.u) annotation (Line(
        points={{21,30},{38,30}},
        color={0,127,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model SwitchGearUp
      import
        FMITest.SimpleConnections.SeriesWithEnumerations1.Internal.GearSelectorType;
      extends Modelica.Blocks.Interfaces.BlockIcon;

      Internal.GearSelectorInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Internal.GearSelectorOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = if u == GearSelectorType.G1 then GearSelectorType.G2 else if u ==
        GearSelectorType.G2 then GearSelectorType.G3 else u;
      Modelica.Utilities.Streams.print("u2 = " + String(u));
      Modelica.Utilities.Streams.print("y2 = " + String(y));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-86,68},{84,28}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString="up"), Text(
              extent={{-82,-58},{74,-86}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end SwitchGearUp;

    model SwitchGearDown
      import
        FMITest.SimpleConnections.SeriesWithEnumerations1.Internal.GearSelectorType;
      extends Modelica.Blocks.Interfaces.BlockIcon;

      Internal.GearSelectorInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Internal.GearSelectorOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = if u == GearSelectorType.G3 then GearSelectorType.G2 else if u ==
        GearSelectorType.G2 then GearSelectorType.G1 else u;
      Modelica.Utilities.Streams.print("u3 = " + String(u));
      Modelica.Utilities.Streams.print("y3 = " + String(y));
      annotation (Icon(graphics={Text(
              extent={{-84,74},{86,34}},
              lineColor={0,0,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid,
              textString="down"), Text(
              extent={{-74,-56},{82,-84}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end SwitchGearDown;
  end FMUModels;

  package Internal "Utility models needed in this test model"
    extends Modelica.Icons.Package;
    type GearSelectorType = enumeration(
        R,
        N,
        D,
        G1,
        G2,
        G3);
    connector GearSelectorInput = input GearSelectorType annotation (
      defaultComponentName="u",
      Icon(graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={0,127,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid)}, coordinateSystem(
          extent={{-100,-100},{100,100}},
          preserveAspectRatio=true,
          initialScale=0.2)),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          initialScale=0.2,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Polygon(
            points={{0,50},{100,0},{0,-50},{0,50}},
            lineColor={0,127,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid), Text(
            extent={{-10,85},{-10,60}},
            lineColor={0,127,0},
            textString="%name")}),
      Documentation(info="<html>
<p>
Connector with one input signal of type GearSelectorType.
</p>
</html>"));
    connector GearSelectorOutput = output GearSelectorType annotation (
      defaultComponentName="y",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Polygon(
            points={{-100,100},{100,0},{-100,-100},{-100,100}},
            lineColor={0,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Polygon(
            points={{-100,51},{0,1},{-100,-49},{-100,51}},
            lineColor={0,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{30,110},{30,60}},
            lineColor={0,127,0},
            textString="%name")}),
      Documentation(info="<html>
<p>
Connector with one output signal of type GearSelectorType.
</p>
</html>"));
    block IntegerToGearSelector "Convert Integer to GearSelectorType signal"
      import GS =
        FMITest.SimpleConnections.SeriesWithEnumerations1.Internal.GearSelectorType;
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Interfaces.IntegerInput u
        "Connector of Integer input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      Internal.GearSelectorOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    protected
      constant GS table[:]={GS.R,GS.N,GS.D,GS.G1,GS.G2,GS.G3};

    equation
      y = table[u];
      Modelica.Utilities.Streams.print("u = " + String(u));
      Modelica.Utilities.Streams.print("y = " + String(y));

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-120,60},{-20,-60}},
                  lineColor={255,127,0},
                  textString="I"),Text(
                  extent={{0,60},{100,-60}},
                  lineColor={0,128,0},
                  textString="G"),Polygon(
                  points={{10,0},{-10,20},{-10,10},{-40,10},{-40,-10},{-10,-10},
                {-10,-20},{10,0}},
                  fillColor={0,127,0},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,127,0})}), Documentation(info="<html>
<p>
This block computes the output <b>y</b>
as <i>Real equivalent</i> of the Integer input <b>u</b>:
</p>
<pre>    y = u;
</pre>
<p>where <b>u</b> is of Integer and <b>y</b> of Real type.</p>
</html>
"));
    end IntegerToGearSelector;
  end Internal;
  annotation (preferredView="Info");
end SeriesWithEnumerations1;
