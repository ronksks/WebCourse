namespace web_course
{
    using System;
    public class UserDTO
    {
        
       
        public UserDTO()
        {
            
        }

        public UserDTO(int id, Nullable<System.DateTime> bdate, string email, string name, Nullable<int> isadmin, Nullable<int> gender)
        {
            this.id = id;
            this.bdate = bdate;
            this.email = email;
            this.name = name;
            this.isadmin = isadmin;
            this.gender = gender;
        }

        public int id { get; set; }
        public Nullable<System.DateTime> bdate { get; set; }
        public string email { get; set; }
        public string name { get; set; }
        public Nullable<int> isadmin { get; set; }
        public Nullable<int> gender { get; set; }
    }
}