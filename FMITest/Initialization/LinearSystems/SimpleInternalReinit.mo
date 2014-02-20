within FMITest.Initialization.LinearSystems;
package SimpleInternalReinit
  "Simple steady state initialization of an FMU, together with a re-initialization of the state from the FMU at an event, leading to a linear system of equations over FMUs during initialization"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    FMUModels.SimpleLinearReinitModel simpleWithReinit(xd(fixed=true,start=0))
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  equation
    connect(simpleWithReinit.y, simpleWithReinit.u) annotation (Line(
        points={{1,10},{14,10},{14,-12},{-32,-12},{-32,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    FMUModels.SimpleLinearReinitModel simpleWithReinit(x(fixed=false))
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  initial equation
      der(simpleWithReinit.x)=0;
  equation
    connect(simpleWithReinit.y, simpleWithReinit.u) annotation (Line(
        points={{1,-10},{14,-10},{14,-32},{-32,-32},{-32,-10},{-22,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model SimpleLinearReinitModel
      extends Modelica.Blocks.Interfaces.SISO;
      Real x(start=2);
      Real xd(start=0);
    equation
      xd = der(x);
      der(x) = -5*x + 2*u;
      y = x + 1;

      when sample(0.1, 0.5) then
        reinit(x, 1);
      end when;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(graphics={Text(
                  extent={{-78,-52},{78,-80}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU"),Text(
                  extent={{-80,64},{76,36}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="linear
reinit")}));
    end SimpleLinearReinitModel;

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
<li> This FMU leads to a linear algebraic equation over the FMU during initialization.</li>
<li> At an event instant, the internal state is re-initialized in the FMU.</li>
</ul>
</html>"));
end SimpleInternalReinit;
