within FMITest.Initialization.NonlinearSystems;
package SimpleParameter
  "Simple steady state initialization of an FMU leading to a nonlinear system of equations over FMUs during initialization. A parameter is back-calculated from the state/steady-state conditions"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    FMUModels.SimpleNonlinearModel simpleWithParameter(
      x(fixed=true, start=3),
      xd(fixed=true, start=0),
      gain(start=-5, fixed=false))
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  equation
    connect(simpleWithParameter.y, simpleWithParameter.u) annotation (Line(
        points={{1,10},{14,10},{14,-12},{-32,-12},{-32,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    FMUModels.SimpleNonlinearModel simpleWithParameter(
      x(fixed=true, start=3),
      gain(start=-5, fixed=false))
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  initial equation
  simpleWithParameter.xd=0;
  equation
    connect(simpleWithParameter.y, simpleWithParameter.u) annotation (Line(
        points={{1,10},{14,10},{14,-12},{-32,-12},{-32,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model SimpleNonlinearModel
      extends Modelica.Blocks.Interfaces.SISO;
      parameter Real gain=-5;
      Real x(start=2);
      output Real xd(start=0);
    equation
      xd = der(x);
      der(x) = gain*x + 0.001*sin(x) + 2*u;
      y = x + 1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Text(
              extent={{-78,-52},{78,-80}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU"), Text(
              extent={{-82,62},{74,34}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="linear
with gain")}));
    end SimpleNonlinearModel;

  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
With this test model the following properties are tested:
</p>

<ul>
<li> Defining an FMU with incomplete initialization (so this FMU can only be simulated
     if additional initialization conditions are defined in the environment where the FMU
     is imported).</li>
<li> In the environment one instance is defined with steady-state and state initialization.
     The value of parameter gain shall be determined so that the initialization conditions
     are fulfilled.</li>
<li> This FMU leads to a nonlinear algebraic equation over the FMU during initialization.</li>
</ul>
</html>"));
end SimpleParameter;
