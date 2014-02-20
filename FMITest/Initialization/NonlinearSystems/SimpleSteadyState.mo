within FMITest.Initialization.NonlinearSystems;
package SimpleSteadyState
  "Simple steady state initialization of an FMU leading to a nonlinear system of equations over FMUs during initialization"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    parameter Real p(start=2,fixed=false);
    FMUModels.SimpleNonlinearModel1 simpleWithFixedState
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    FMUModels.SimpleNonlinearModel2 simpleWithSteadyState(x(start=p))
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  initial equation
    der(simpleWithSteadyState.x) = 0;
  equation
    connect(simpleWithFixedState.y, simpleWithFixedState.u) annotation (Line(
        points={{1,50},{14,50},{14,28},{-32,28},{-32,50},{-22,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(simpleWithSteadyState.y, simpleWithSteadyState.u) annotation (Line(
        points={{1,-10},{14,-10},{14,-32},{-32,-32},{-32,-10},{-22,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    parameter Real p(start=2,fixed=false);
    FMUModels.SimpleNonlinearModel1 simpleWithFixedState
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    FMUModels.SimpleNonlinearModel2 simpleWithSteadyState(x(start=p))
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  initial equation
    der(simpleWithSteadyState.x) = 0;

  equation
    connect(simpleWithFixedState.y, simpleWithFixedState.u) annotation (Line(
        points={{1,50},{14,50},{14,28},{-32,28},{-32,50},{-22,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(simpleWithSteadyState.y, simpleWithSteadyState.u) annotation (Line(
        points={{1,-10},{14,-10},{14,-32},{-32,-32},{-32,-10},{-22,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model SimpleNonlinearModel1
      extends Modelica.Blocks.Interfaces.SISO;
      Real x(start=2, final fixed=true);
      Real xd;
    equation
      xd = der(x);
      der(x) = -5*x + 0.001*sin(x) + 2*u;
      y = x + 1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(graphics={Text(
              extent={{-78,-56},{78,-84}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"), Text(
              extent={{-80,74},{76,46}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="nonlinear")}));
    end SimpleNonlinearModel1;

    model SimpleNonlinearModel2
      extends SimpleNonlinearModel1;
      annotation (Icon(graphics={Text(
              extent={{-24,46},{24,20}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="2")}));
    end SimpleNonlinearModel2;
  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
With this test model the following properties are tested:
</p>

<ul>
<li> Defining an FMU with incomplete initialization (so this FMU can only be simulated
     if additional initialization conditions are defined in the environment where the FMU
     is imported).</li>
<li> In the environment two instances are defined: The first instance is defined
     with a fixed state and the second instance is defined in steady-state.</li>
<li> This FMU leads to a nonlinear algebraic equation over the FMU during initialization.</li>
</ul>
</html>"));
end SimpleSteadyState;
