namespace web_course 
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Xml;
    using System.Xml.Serialization;
    public class RecipeDTO
    {
        public RecipeDTO(int id, string title, string image, Nullable<int> rate, Nullable<int> time,  string description, List<IngredientDTO> ings, UserDTO owner)
        {
            this.id = id;
            this.title = title;
            this.img_path = image;
            this.rate = rate;
            this.time = time;
            this.description = description;
            this.IngredientsInRecipes = ings;
            this.owner = owner;
        }
        public RecipeDTO()
        {
            this.IngredientsInRecipes = new List<IngredientDTO>();
        }

        public int id { get; set; }
        public string title { get; set; }
        public string img_path { get; set; }
        public Nullable<int> rate { get; set; }
        public string description { get; set; }
        public Nullable<int> time { get; set; }

        public List<IngredientDTO> IngredientsInRecipes { get; set; }
        public UserDTO owner { get; set; }

        public override string ToString()
        {

            XmlSerializer xsSubmit = new XmlSerializer(typeof(RecipeDTO));
            var subReq = this;
            var xml = "";

            using (var sww = new StringWriter())
            {
                using (XmlWriter writer = XmlWriter.Create(sww))
                {
                    xsSubmit.Serialize(writer, subReq);
                    xml = sww.ToString(); // Your XML
                }
            }
            return xml;
        }
    }
}