within FMITest.SimpleConnections;
package Series2
  "Simple series connection of two FMUs consisting of a first order system per FMU"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(initType=Modelica.Blocks.Types.Init.InitialState,
        T=0.2) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(
      k=1.2,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      T=0.1) annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Blocks.Sources.Step step
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(firstOrder1.y, firstOrder2.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, firstOrder1.u) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.FirstOrder1 firstOrder1(initType=Modelica.Blocks.Types.Init.InitialState,
        T=0.2) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.FirstOrder2 firstOrder2(
      k=1.2,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      T=0.1) annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Blocks.Sources.Step step
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(firstOrder1.y, firstOrder2.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, firstOrder1.u) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.8));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.FirstOrder1 firstOrder1(initType=Modelica.Blocks.Types.Init.InitialState,
        T=0.2) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.FirstOrder2 firstOrder2(
      k=1.2,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      T=0.1) annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Blocks.Sources.Step step
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  equation
    connect(firstOrder1.y, firstOrder2.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(step.y, firstOrder1.u) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.8));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model FirstOrder1
      extends Modelica.Blocks.Continuous.FirstOrder;
      annotation (Icon(graphics={Text(
                  extent={{-46,88},{62,56}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end FirstOrder1;

    model FirstOrder2
      extends Modelica.Blocks.Continuous.FirstOrder;
      annotation (Icon(graphics={Text(
                  extent={{-46,88},{62,56}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end FirstOrder2;
  end FMUModels;
  annotation (preferredView="Info");
end Series2;
