import mysql.connector

def err():
    print("Action not recognized, please try again")

def search():

    print("Build your search. Select a number(s) and specify what you want to search for. Type \"Search\" to conduct the query")

    stringMap = {
        "1" : "lower(city)",
        "3" : "lower(make_name)",
        "5" : "lower(body_type)",
        "6" : "lower(listing_color)",
        "8" : "maximum_seating",
        "9" : "lower(engine_type)",
        "10" : "listing_id"
    }
    rangeMap = {
        "2" : "price",
        "4" : "year",
        "7" : "mileage"
    }
    sortBy = {
        "list date" : "listed_date", 
        "price" : "price", 
        "year" : "year"
    }
    stringAns, rangeAns = {}, {}

    # SortByAns example = (price, ascending)
    sortByAns = ()
    while True:
        print("1 Location (City)\n2 Price\n3 Make\n4 Year\n5 Body Type\n6 Colour\n7 Mileage\n8 Seating Capacity\n9 Engine\n10 List ID\n11 Sort By")
        param = input().lower()
        if param == "search":
            break

        if param in stringMap:
            column = stringMap[param]
            print("Value:")
            ans = input().lower()
            stringAns[column] = ans
            print(column + " section updated")
        elif param in rangeMap:
            column = rangeMap[param]
            print("Lower Bound:")
            low = input()
            print("Upper Bound:")
            high = input()
            rangeAns[column] = (low,high)
            print(column + " section updated")
        elif param == "11":
            print("Sort by (List Date, Price, Year):")
            category = input().lower()
            types = set(["asc", "desc"])
            print("asc or desc:")
            type = input().lower()
            if category not in sortBy or type not in types:
                break

            sortByAns = (sortBy[category], type)

        else:
            err()

    print(stringAns, rangeAns, sortByAns)
    query = "select * from <variable name for view> where true"
    for k,v in stringAns.items():
        query += " and " + k + "=" + "'" + v + "'"

    for k,v in rangeAns.items():
        query += " and " + k + " between " + v[0] + " and " + v[1]
    
    if len(sortByAns):
        query += " sort by " + sortByAns[0] + " " + sortByAns[1]
        
    return query



def create():
    
    requiredInfo = ["vin","listing_id","listed_date","city","dealer_zip","franchise_dealer",
    "is_certified","is_cpo","is_oemcpo","latitude","longitude","daysonmarket",
    "sp_id","sp_name","seller_rating","savings_amount", "price","owner_count","is_new","description","major_options"
    ]
    requiredAns = {}
    for info in requiredInfo:
        tmp=""
        if(info=="listed_date"):
            tmp=" (YYYY-MM-DD)"
        print("Value of " + info + tmp+":")
        requiredAns[info] = input().lower()

    print(requiredAns)


def modify():
    print("Listing ID to modify:")
    listingID = input().lower()
    print("Select a number(s) and specify what you want to modify. Type \"Modify\" to modify the listing ID")

    modifyMap = {
        "1" : "city",
        "2" : "dealer_zip",
        "3" : "latitude",
        "4" : "longitude",
        "5" : "savings_amount",
        "6" : "price",
        "7" : "description"
    }
    modifyAns = {}
    while True:
        print("1 City\n2 Dealer Zip\n3 Latitude\n4 Longitude\n5 Savings Amount\n6 Price\n7 Description")
        param = input().lower()
        if param == "modify":
            break

        if param in modifyMap:
            column = modifyMap[param]
            print("New Value:")
            ans = input().lower()
            modifyAns[column] = ans
            print(column + " section updated")
        else:
            err()

    print(listingID, modifyAns)
    
    ####### NEEDS TO BE CHANGED! #######
    query = "UPDATE listing SET city='toronto', dealer_zip='L9T', latitude='10.99' WHERE listing_id="+listingID


def delete():
    print("Listing ID:")
    listingID = input()

    print("Deleting: " + listingID)
    query = "DELETE FROM listing WHERE listing_id=" + listingID
    return query

def main():
    # Connection to database and test query
    # db = mysql.connector.connect(
    #     host = "marmoset04.shoshin.uwaterloo.ca",
    #     user = "zj2yan",
    #     passwd = "Simon_123",
    #     database = "NHL_356"
    # )
    # cur = db.cursor()

    # Variables and mappings
    action = ""
    actions = {
        "search" : search,
        "create" : create,
        "modify" : modify,
        "delete" : delete
    }

    # Interface
    print("Welcome to Used Car Data")
    while True:
        print("What do you want to do? (Search, Create, Modify, Delete)")
        action = input().lower()
        if action in actions:
            break
        err()

    query = actions[action]()

    print(query)
    # Execute query
    # cur.execute(query)

    # for i in cur:
    #     print(i)




if __name__ == "__main__":
    main()
