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

    public partial class Ingredient
    {
        const int VEGAN = 1;
        const int DAIRY = 2;
        const int MEAT = 4;
        const int FISH = 8;
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Ingredient()
        {
            this.IngredientsInRecipes = new HashSet<IngredientsInRecipe>();
        }
    
        public int id { get; set; }
        public string name { get; set; }
        public string unit_type { get; set; }
        public string img_path { get; set; }
        public int source { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<IngredientsInRecipe> IngredientsInRecipes { get; set; }

        internal bool containsMeat()
        {
            return (source & MEAT) != 0;
        }

        internal bool containsDairy()
        {
            return (source & DAIRY) != 0;
        }

        internal bool containsFish()
        {
            return (source & FISH) != 0;
        }

        internal bool isVegan()
        {
            return (!containsDairy() && !containsFish() && !containsMeat());
        }

        public override string ToString()
        {
            List<String> l = new List<string>() {name.Trim(), unit_type.Trim(), Convert.ToString(source) };
            return String.Join("| ", l.ToArray());
        }
    }
}
