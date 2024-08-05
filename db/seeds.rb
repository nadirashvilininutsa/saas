# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if PlanDescriptionPlan.count.zero?
  free_plan = Plan.find_or_create_by!( name: "Free", price: 0 )
  premium_plan = Plan.find_or_create_by!( name: "Premium", price: 10 )

  plan_common_descriptions = ["Unlimited file uploads", "Responsive design", "Access anywhere"]

  plan_common_descriptions.each do |description|
    plan_description = PlanDescription.find_or_create_by!(content: description)
    free_plan.plan_descriptions << plan_description
    premium_plan.plan_descriptions << plan_description
  end

  free_plan.plan_descriptions.find_or_create_by!(content: "1 project")
  premium_plan.plan_descriptions.find_or_create_by!(content: "Unlimited projects")
end


if RolePermission.count.zero?
  # # Create or find roles
  # super_admin = Role.find_or_create_by!(name: 'Super Admin')
  organization_admin = Role.find_or_create_by!(name: 'Organization Admin')
  project_manager = Role.find_or_create_by!(name: 'Project Manager')
  employee = Role.find_or_create_by!(name: 'Employee')
  viewer = Role.find_or_create_by!(name: 'Viewer')


  # Create or find permissions and assign them to super_admin
  permissions = [
    { name: 'manage_organization', description: 'Ability to manage organization settings - create, edit and delete organization, change plans' },
    { name: 'add_delete_employees', description: 'Invite employees to join organization and delete them' },
    { name: 'view_employees', description: 'View employee details, their project, roles and tasks' },
    { name: 'manage_user_permissions', description: 'Ability to manage custom permissions for specific users' },
    { name: 'manage_user_roles', description: 'Ability to change user roles' },
    { name: 'assign_employees_projects', description: 'Ability to assign/remove projects to/from users' },
    { name: 'assign_employees_tasks', description: 'Ability to assign/remove tasks to/from users' },
    { name: 'manage_projects', description: 'Ability to create, edit, complete, reopen or cancel own projects' },
    { name: 'view_projects', description: 'Ability to view projects' },
    { name: 'manage_tasks', description: 'Ability to create, edit and cancel tasks' },
    { name: 'complete_tasks', description: 'Ability to complete tasks' },
    { name: 'view_tasks', description: 'Ability to view tasks' },
    { name: 'manage_artifacts', description: 'Ability to upload, edit and delete own artifacts' },
    { name: 'view_artifacts', description: 'Ability to view artifacts' },
    { name: 'view_statistics', description: 'Ability to view organization or project statistics' },
    { name: 'comment_on_tasks', description: 'Ability to comment on tasks' },
    { name: 'view_comments', description: 'Ability to view comments on tasks' }
  ]

  permissions.each do |perm|
    permission = Permission.find_or_create_by!(perm)
    # super_admin.permissions << permission
  end

  # Assign permissions to roles
  # organization_admin
  organization_admin.permissions << Permission.find_by(name: 'manage_organization')
  organization_admin.permissions << Permission.find_by(name: 'add_delete_employees')
  organization_admin.permissions << Permission.find_by(name: 'view_employees')
  organization_admin.permissions << Permission.find_by(name: 'manage_user_permissions')
  organization_admin.permissions << Permission.find_by(name: 'manage_user_roles')
  organization_admin.permissions << Permission.find_by(name: 'assign_employees_projects')
  organization_admin.permissions << Permission.find_by(name: 'manage_projects')
  organization_admin.permissions << Permission.find_by(name: 'view_projects')
  organization_admin.permissions << Permission.find_by(name: 'view_tasks')
  organization_admin.permissions << Permission.find_by(name: 'view_artifacts')
  organization_admin.permissions << Permission.find_by(name: 'view_statistics')
  organization_admin.permissions << Permission.find_by(name: 'view_comments')

  # project_manager
  project_manager.permissions << Permission.find_by(name: 'view_employees')
  project_manager.permissions << Permission.find_by(name: 'assign_employees_projects')
  project_manager.permissions << Permission.find_by(name: 'assign_employees_tasks')
  project_manager.permissions << Permission.find_by(name: 'manage_projects')
  project_manager.permissions << Permission.find_by(name: 'view_projects')
  project_manager.permissions << Permission.find_by(name: 'manage_tasks')
  project_manager.permissions << Permission.find_by(name: 'view_tasks')
  project_manager.permissions << Permission.find_by(name: 'manage_artifacts')
  project_manager.permissions << Permission.find_by(name: 'view_artifacts')
  project_manager.permissions << Permission.find_by(name: 'comment_on_tasks')
  project_manager.permissions << Permission.find_by(name: 'view_comments')

  # employee
  employee.permissions << Permission.find_by(name: 'view_projects')
  employee.permissions << Permission.find_by(name: 'manage_tasks')
  employee.permissions << Permission.find_by(name: 'complete_tasks')
  employee.permissions << Permission.find_by(name: 'view_tasks')
  employee.permissions << Permission.find_by(name: 'manage_artifacts')
  employee.permissions << Permission.find_by(name: 'view_artifacts')
  employee.permissions << Permission.find_by(name: 'comment_on_tasks')
  employee.permissions << Permission.find_by(name: 'view_comments')

  # viewer
  viewer.permissions << Permission.find_by(name: 'view_employees')
  viewer.permissions << Permission.find_by(name: 'view_projects')
  viewer.permissions << Permission.find_by(name: 'view_tasks')
  viewer.permissions << Permission.find_by(name: 'view_artifacts')
  viewer.permissions << Permission.find_by(name: 'view_statistics')
  viewer.permissions << Permission.find_by(name: 'view_comments')
end
