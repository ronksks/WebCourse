//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace web_course
{
    using System;
    using System.Collections.Generic;
    
    public partial class IngredientsInRecipe
    {
        public int recipe_id { get; set; }
        public int ingredient_id { get; set; }
        public string qty { get; set; }
    
        public virtual Ingredient Ingredient { get; set; }
        public virtual Recipe Recipe { get; set; }

        public override string ToString()
        {
            return Ingredient.ToString() + "->" + qty.Trim();
        }
    }

}
