namespace web_course
{
    using System;
    using System.Collections.Generic;

    public partial class IngredientDTO
    {
        const int VEGAN = 1;
        const int DAIRY = 2;
        const int MEAT = 4;
        const int FISH = 8;
       
        public IngredientDTO()
        {
            
        }

        public IngredientDTO(int id, string name, string unit, string image, int source, string qty)
        {
            this.id = id;
            this.name = name;
            this.unit_type = unit;
            this.img_path = image;
            this.source = source;
            this.qty = qty;
        }

        public int id { get; set; }
        public string name { get; set; }
        public string unit_type { get; set; }
        public string img_path { get; set; }
        public int source { get; set; }
        public string qty { get; set; }
    }
}
