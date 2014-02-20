within FMITest.Initialization.NonlinearSystems;
package SimpleReinit
  "Simple steady state initialization of an FMU, together with a re-initialization of the state at an event, leading to a nonlinear algebraic system of equations during initialization"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    FMUModels.SimpleNonlinearModel simpleLinearReinit
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  initial equation
    der(simpleLinearReinit.x) = 0;
  equation
    when sample(0.1, 0.5) then
      reinit(simpleLinearReinit.x, 1);
    end when;

    connect(simpleLinearReinit.y, simpleLinearReinit.u) annotation (Line(
        points={{1,30},{14,30},{14,8},{-32,8},{-32,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.2));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    FMUModels.SimpleNonlinearModel simpleLinearReinit(x(fixed=false))
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  initial equation
    der(simpleLinearReinit.x) = 0;
  equation
    when sample(0.1, 0.5) then
      reinit(simpleLinearReinit.x, 1);
    end when;

    connect(simpleLinearReinit.y, simpleLinearReinit.u) annotation (Line(
        points={{1,30},{14,30},{14,8},{-32,8},{-32,30},{-22,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.2));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model SimpleNonlinearModel
      extends Modelica.Blocks.Interfaces.SISO;
      Real x(start=2);
      Real xd(start=0);
    equation
      xd = der(x);
      der(x) = -5*x + 0.001*sin(x) + 2*u;
      y = x + 1;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(graphics={Text(
                  extent={{-78,-52},{78,-80}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Text(
                  extent={{-82,64},{74,36}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="nonlinear")}));
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
<li> In the environment one instance is defined with steady-state initialization
     in an initial equation section.</li>
<li> This FMU leads to a nonlinear algebraic equation over the FMU during initialization.</li>
<li> At an event instant, the internal state is re-initialized from the environment.</li>
</ul>
</html>"));
end SimpleReinit;
