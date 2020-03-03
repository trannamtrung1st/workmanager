using Newtonsoft.Json;
using WorkManager.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace WorkManager.Data.ViewModels
{
    public partial class ProductsViewModel : BaseViewModel<Products>
    {
        [JsonProperty("id")]
        public string Id { get; set; }
        [JsonProperty("name")]
        public string Name { get; set; }

        public ProductsViewModel(Products entity) : base(entity)
        {
        }

        public ProductsViewModel()
        {
        }

    }

    public class CreateProductViewModel : BaseViewModel<Products>
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        public CreateProductViewModel()
        {
        }

        public CreateProductViewModel(Products entity) : base(entity)
        {
        }

    }

    public class EditProductViewModel : BaseViewModel<Products>
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        public EditProductViewModel()
        {
        }

        public EditProductViewModel(Products entity) : base(entity)
        {
        }

    }

    public class ProductGeneralFields
    {
        public const string INFO = "info";

        public static readonly IDictionary<string, string[]> Mapping =
            new Dictionary<string, string[]>()
            {
                {
                    INFO, new string[]{ "Id","Name" }
                }
            };
    }

    public class ProductSortFields
    {
        public const string Name = "name";
    }

    public class ProductFilter
    {
        public int[] ids { get; set; }
        public string[] name_contains { get; set; }
    }

}