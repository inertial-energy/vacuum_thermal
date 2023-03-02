[Mesh]
  type = MeshGeneratorMesh
  [file_mesh]
    type = FileMeshGenerator
    file = cylinder_within_cylinder.msh
  []
  [rotor_outer_surface_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = file_mesh
    primary_block = 'rotor_volume'
    paired_block = 'vacuum_volume'
    new_boundary = 'rotor_outer_surface_sideset'
  []
  [stator_inner_surface_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = rotor_outer_surface_sideset
    primary_block = 'stator_volume'
    paired_block = 'vacuum_volume'
    new_boundary = 'stator_inner_surface_sideset'
  [../]
  []

[Variables]
  [Temperature]
  []
[]

[ICs]
  [rotor_IC]
    type = ConstantIC
    variable = Temperature
    block = 'rotor_volume'
    value = 80
  []
  [vacuum_IC]
    type = ConstantIC
    variable = Temperature 
    block = 'vacuum_volume'
    value = 80
  []
  [stator_IC]
    type = ConstantIC
    variable = Temperature 
    block = 'stator_volume'
    value = 300
  []
[]

[Kernels]
  [heat_conduction]
    type = HeatConduction
    variable = Temperature
  []
  [heat_conduction_time_derivative]
    type = HeatConductionTimeDerivative
    variable = Temperature
  []
[]

[GrayDiffuseRadiation]
  [vacuum_radiation]
    boundary = 'stator_inner_surface_sideset rotor_outer_surface_sideset'
    emissivity = '0.03 0.03'
    n_patches = '2 2'
    temperature = Temperature
    ray_tracing_face_type = 'GAUSS'
    # fixed_temperature_boundary = 'stator_inner_surface_sideset'
    # fixed_boundary_temperatures = 300
  []
[]

[Materials]
  [thermal_rotor]
    type = HeatConductionMaterial
    thermal_conductivity = 45.0
    specific_heat = 0.5
    block = 'rotor_volume'
  []
  [thermal_vacuum]
    type = HeatConductionMaterial
    thermal_conductivity = 0
    specific_heat = 0
    block = 'vacuum_volume'
  []
  [thermal_stator]
    type = HeatConductionMaterial
    thermal_conductivity = 25.0
    specific_heat = 1
    block = 'stator_volume'
  []
  [density]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = 8000.0
  []
[]

# [BCs]
#  [temperature_stator]
#    type = DirichletBC
#    variable = Temperature
#    value = 300
#    boundary = 'stator_inner_surface'
#  []
# []

[Executioner]
  type = Transient
  end_time = 5
  dt = 1
[]

[Outputs]
  exodus = true
[]
