within FMITest.VirtualLoops;
package SRFlipFlop
  "SR Flip Flop model that leads to a loop structure, but it is an artifical loop due to a memory element (pre)"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    parameter Boolean Qini=false "Start value of Q at initial time";
    Modelica.Blocks.Interfaces.BooleanOutput Q annotation (Placement(
          transformation(extent={{76,50},{96,70}}, rotation=0)));
    Modelica.Blocks.Interfaces.BooleanOutput QI annotation (Placement(
          transformation(extent={{74,-70},{94,-50}}, rotation=0)));
    Modelica.Blocks.Logical.Nor nor annotation (Placement(transformation(extent
            ={{-20,20},{0,40}},rotation=0)));
    Modelica.Blocks.Logical.Nor nor1 annotation (Placement(transformation(
            extent={{-20,-20},{0,0}}, rotation=0)));
    Modelica.Blocks.Logical.Pre pre(pre_u_start=not (Qini)) annotation (
        Placement(transformation(extent={{10,20},{30,40}}, rotation=0)));
    Modelica.Blocks.Sources.SampleTrigger trigger1(period=0.5)
      annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    Modelica.Blocks.Sources.SampleTrigger trigger2(period=0.5, startTime=0.3)
      annotation (Placement(transformation(extent={{-90,-28},{-70,-8}})));
  equation
    connect(nor1.y, nor.u2) annotation (Line(points={{1,-10},{40,-10},{40,-40},
            {-60,-40},{-60,22},{-22,22}},color={255,0,255}));
    connect(nor1.y, Q) annotation (Line(points={{1,-10},{60,-10},{60,60},{86,60}},
          color={255,0,255}));
    connect(nor.y, pre.u)
      annotation (Line(points={{1,30},{8,30}}, color={255,0,255}));
    connect(pre.y, nor1.u1) annotation (Line(points={{31,30},{40,30},{40,10},{-40,
            10},{-40,-10},{-22,-10}}, color={255,0,255}));
    connect(pre.y, QI) annotation (Line(points={{31,30},{68,30},{68,-60},{84,-60}},
          color={255,0,255}));

    connect(QI, QI) annotation (Line(
        points={{84,-60},{84,-60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(trigger1.y, nor.u1) annotation (Line(
        points={{-69,30},{-22,30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(trigger2.y, nor1.u2) annotation (Line(
        points={{-69,-18},{-22,-18}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.SampleTrigger trigger1(period=0.5)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.SampleTrigger trigger2(period=0.5, startTime=0.3)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    Modelica.Blocks.Interfaces.BooleanOutput Q annotation (Placement(
          transformation(extent={{86,50},{106,70}},rotation=0)));
    Modelica.Blocks.Interfaces.BooleanOutput QI annotation (Placement(
          transformation(extent={{84,-70},{104,-50}},rotation=0)));
    FMUModels.Nor nor
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    FMUModels.NorPre norPre
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
  equation
    connect(QI, QI) annotation (Line(
        points={{94,-60},{94,-60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(trigger2.y, nor.u2) annotation (Line(
        points={{-59,-30},{-36,-30},{-36,-38},{-2,-38}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(trigger1.y, norPre.u1) annotation (Line(
        points={{-59,30},{-2,30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(norPre.y, QI) annotation (Line(
        points={{21,30},{60,30},{60,-60},{94,-60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(norPre.y, nor.u1) annotation (Line(
        points={{21,30},{32,30},{32,-10},{-20,-10},{-20,-30},{-2,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(nor.y, norPre.u2) annotation (Line(
        points={{21,-30},{42,-30},{42,-52},{-30,-52},{-30,22},{-2,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(nor.y, Q) annotation (Line(
        points={{21,-30},{48,-30},{48,-30},{72,-30},{72,60},{96,60}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.SampleTrigger trigger1(period=0.5)
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.SampleTrigger trigger2(period=0.5, startTime=0.3)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    Modelica.Blocks.Interfaces.BooleanOutput Q annotation (Placement(
          transformation(extent={{86,50},{106,70}},rotation=0)));
    Modelica.Blocks.Interfaces.BooleanOutput QI annotation (Placement(
          transformation(extent={{84,-70},{104,-50}},rotation=0)));
    FMUModels.Nor nor
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    FMUModels.NorPre norPre
      annotation (Placement(transformation(extent={{0,20},{20,40}})));
  equation
    connect(QI, QI) annotation (Line(
        points={{94,-60},{94,-60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(trigger2.y, nor.u2) annotation (Line(
        points={{-59,-30},{-36,-30},{-36,-38},{-2,-38}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(trigger1.y, norPre.u1) annotation (Line(
        points={{-59,30},{-2,30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(norPre.y, QI) annotation (Line(
        points={{21,30},{60,30},{60,-60},{94,-60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(norPre.y, nor.u1) annotation (Line(
        points={{21,30},{32,30},{32,-10},{-20,-10},{-20,-30},{-2,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(nor.y, norPre.u2) annotation (Line(
        points={{21,-30},{42,-30},{42,-52},{-30,-52},{-30,22},{-2,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(nor.y, Q) annotation (Line(
        points={{21,-30},{48,-30},{48,-30},{72,-30},{72,60},{96,60}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model Nor
      extends Modelica.Blocks.Logical.Nor;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-86,88},{82,60}},
              lineColor={0,0,255},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              textString="to FMU")}));
    end Nor;

    model NorPre
      extends Modelica.Blocks.Interfaces.partialBooleanSI2SO;
      parameter Boolean Qini=false "Start value of Q at initial time";
      Modelica.Blocks.Logical.Nor nor annotation (Placement(transformation(
              extent={{-40,-10},{-20,10}}, rotation=0)));
      Modelica.Blocks.Logical.Pre pre(pre_u_start=not (Qini)) annotation (
          Placement(transformation(extent={{0,-10},{20,10}}, rotation=0)));
    equation
      connect(u1, nor.u1) annotation (Line(
          points={{-120,0},{-42,0}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(u2, nor.u2) annotation (Line(
          points={{-120,-80},{-58,-80},{-58,-8},{-42,-8}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(nor.y, pre.u) annotation (Line(
          points={{-19,0},{-2,0}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(pre.y, y) annotation (Line(
          points={{21,0},{110,0}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
              extent={{-90,90},{78,62}},
              lineColor={0,0,255},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              textString="to FMU"), Text(
              extent={{-92,-16},{88,-52}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={245,245,245},
              textString="Nor + Pre")}));
    end NorPre;
  end FMUModels;
  annotation (preferredView="Info");
end SRFlipFlop;
