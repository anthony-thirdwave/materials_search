Material.destroy_all
Company.destroy_all
data = [{ section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Bar & rod, exotic alloys", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Bonderized", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Cobalt", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Galvalume", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Hastelloy", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Inconel", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Low-melt alloys", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Plate, alloy steel", cat_3: "Plate, exotic alloys" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Sheet & coil, exotic alloys", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Strip, exotic alloys", cat_3: "" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Tube & pipe, alloy", cat_3: "Tube & pipe, chrome/moly" },
        { section: "Materials", cat_1: "Proprietary metals and other alloys", cat_2: "Tube & pipe, alloy", cat_3: "Tube & pipe, exotic alloys" },

        { section: "Materials", cat_1: "Aluminun", cat_2: "Bar & rod", cat_3: "Bar & rod, aluminum alloys" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Bar & rod", cat_3: "Bar & rod, extruded" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Casting alloys", cat_3: "" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Coiled sheet", cat_3: "" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Filters", cat_3: "" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Ingot", cat_3: "" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Plate", cat_3: "Plate, aluminum alloys" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Sheet & coil", cat_3: "Sheet & coil, aluminum alloys" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Strip", cat_3: "Strip, aluminum alloys" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Tooling plate", cat_3: "" },
        { section: "Materials", cat_1: "Aluminun", cat_2: "Tube & pipe", cat_3: "Tube & pipe, aluminum alloys" }
       ]
Material.create(data)
Company.create(name: "Beulah Processing Inc.", address: "N9202 Oakwood Ln.", city: "Mukwonago", state: "WI", zip: "53149", country: "USA")
Company.create(name: "Regents Smithing LLC.", address: "5050 S. Lake Shore Dr.", city: "Chicago", state: "IL.", zip: "60615", country: "USA")
Company.create(name: "Astor's Cobalt Co.", address: "25 E. Banks St.", city: "Chicago", state: "IL.", zip: "60610", country: "USA")

i = 1
while i < 13 do
  p = Material.find(i)
  c = Company.find(1)
  p.companies << c
  i = i + 1
end

while i < 24 do
  p = Material.find(i)
  c = Company.find(2)
  p.companies << c
  i = i + 1
end

c = Company.find(3)
m = Material.find(3)

m.companies << c
puts "Updated Database Relations"
