import EctoEnum

defenum(RolesEnum, :role, ~w(super_admin admin user)a)

# super_admin
# admin

# moderator
# commenter

# interviewer
# interviewee

# site_owner
# site_manager / site_admin

# viewer / spectator
# guest

# Unnecessary, as groups can define action and they can just be users instead:

# author
# artist
# musician
# photographer

defenum(GroupsEnum, :groups, ~w(photographer)a)
# defenum(UserStatusEnum, :user_status, ~w(registered active inactive archived)a)
# defenum(PhotosStatusEnum, :photos_status, ~w(private public)a)
# defenum(PostStatusEnum, :post_status, ~w(draft published)a)
