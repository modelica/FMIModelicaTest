within FMITest.Initialization.LinearSystems;
package SimpleSteadyState
  "Simple steady state initialization of an FMU leading to a linear system of equations over FMUs during initialization"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    parameter Real p(start=2,fixed=false);
    FMUModels.SimpleLinearModel1 simpleWithFixedState
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    FMUModels.SimpleLinearModel2 simpleWithSteadyState(x(start=p))
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  initial equation
    der(simpleWithSteadyState.x) = 0;

  equation
    connect(simpleWithSteadyState.y, simpleWithSteadyState.u) annotation (Line(
        points={{1,-30},{14,-30},{14,-52},{-34,-52},{-34,-30},{-22,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(simpleWithFixedState.y, simpleWithFixedState.u) annotation (Line(
        points={{1,30},{12,30},{12,10},{-34,10},{-34,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    parameter Real p(start=2,fixed=false);
    FMUModels.SimpleLinearModel1 simpleWithFixedState
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    FMUModels.SimpleLinearModel2 simpleWithSteadyState(x(start=p))
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  initial equation
    der(simpleWithSteadyState.x) = 0;

  equation
    connect(simpleWithSteadyState.y, simpleWithSteadyState.u) annotation (Line(
        points={{1,-30},{14,-30},{14,-52},{-34,-52},{-34,-30},{-22,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(simpleWithFixedState.y, simpleWithFixedState.u) annotation (Line(
        points={{1,30},{12,30},{12,10},{-34,10},{-34,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model SimpleLinearModel1
      extends Modelica.Blocks.Interfaces.SISO;
      Real x(start=2, final fixed=true);
      Real xd;
    equation
      xd = der(x);
      der(x) = -5*x + 2*u;
      y = x + 1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(graphics={
            Text(
              extent={{-78,-52},{78,-80}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"),
            Text(
              extent={{-82,86},{74,58}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="linear"),
            Text(
              extent={{-84,14},{86,-14}},
              lineColor={0,0,0},
              textString="x.start=2")}));
    end SimpleLinearModel1;

    model SimpleLinearModel2
      extends SimpleLinearModel1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(graphics={
            Text(
              extent={{-78,-52},{78,-80}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"),
            Text(
              extent={{-26,58},{22,32}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="2"),
            Text(
              extent={{-84,14},{86,-14}},
              lineColor={0,0,0},
              textString="x.start=2")}));
    end SimpleLinearModel2;
  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
With this test model it is tested how the initialization of an FMU
can be changed in the environment where this FMU is used. There are two
identical FMUs in this model:
</p>

<ul>
<li> simpleWithFixedState uses the default initialization defined in the FMU</li>

<li> simpleWithSteadyState is the same FMU, but provides a parameter to the start value of the
     FMU and this parameter has fixed=false. Additionally, the state derivative of the FMU
     is set to zero in the environment leading to a steady-state condition.</li>
</ul>
</html>"));
end SimpleSteadyState;
