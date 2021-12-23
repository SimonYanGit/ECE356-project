import mysql.connector
import pandas as pd

class Table:
    def __init__(self, name, req, opt, ignore):
        self.name = name
        self.req = req
        self.opt = opt
        self.ignore = ignore

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
        elif param in rangeMap:
            column = rangeMap[param]
            print("Lower Bound:")
            low = input()
            print("Upper Bound:")
            high = input()
            rangeAns[column] = (low,high)
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

    # print(stringAns, rangeAns, sortByAns)
    query = "select * from search_view where true"
    for k,v in stringAns.items():
        query += " and " + k + "=" + "'" + v + "'"

    for k,v in rangeAns.items():
        query += " and " + k + " between " + v[0] + " and " + v[1]
    
    if len(sortByAns):
        query += " order by " + sortByAns[0] + " " + sortByAns[1]
        
    return query



def create():

    # Res holds list of queries

    # Make tables
    tables = [
        Table("car", ["vin", "listing_color",], ["main_picture_url", "mileage"], False),
        Table("listing", ["listing_id", "listed_date", "daysonmarket", "price"], ["is_certified", "is_cpo", "is_oemcpo", "savings_amount", "owner_count", "is_new", "description", "major_options"], False),
        Table("list_relation", ["vin", "listing_id"], [], False),
        Table("city", ["city"], [], True),
        Table("seller", ["sp_id"], ["sp_name", "dealer_zip", "franchise_dealer", "latitude", "longitude", "seller_rating"], True),
        Table("has_relation", ["sp_id", "city"], [], True),
        Table("list1_relation", ["listing_id", "sp_id"], [], False),
        Table("make", ["make_name"], [], True),
        Table("model", ["model_id", "model_name", "trimid", "body_type", "year"], [], True),
        Table("manufactures_relation", ["make_name", "model_id"], [], False),
        Table("specifies_relation", ["vin", "model_id"], [], False)
    ]

    # Gather required info
    requiredInfo = {
        "vin": "VIN",
        "listing_color": "Color",
        "listing_id": "Listing ID",
        "listed_date": "Date",
        "daysonmarket": "Days on Market",
        "price": "Price",
        "city": "City",
        "sp_id": "Dealership User ID",
        "make_name": "Make Name",
        "model_id": "Model ID",
        "model_name": "Model Name",
        "trimid": "Trim ID",
        "body_type": "Body Type",
        "year": "Year"
    }

    requiredAns = {}
    for k,v in requiredInfo.items():
        ans = ""
        while True:
            print(v + ": ")
            ans = input().lower()
            if ans:
                break
            else:
                err()

        requiredAns[k] = ans

    # Gather optional info
    optionalInfo = {
        "1": "main_picture_url",
        "2": "mileage",
        "3": "is_certified",
        "4": "is_cpo",
        "5": "is_oemcpo",
        "6": "savings_amount",
        "7": "owner_count",
        "8": "is_new",
        "9": "description",
        "10": "major_options",
        "11": "sp_name",
        "12": "dealer_zip",
        "13": "latitude",
        "14": "longitude",
        "15": "seller_rating",
        "16": "franchise_dealer"
    }

    optionalAns = {}
    print("Add additional information. Select a number(s) and specify the value of the field. Type \"Create\" to conduct the query")
    while True:
        print("1 Picture URL\n2 Mileage\n3 Is certified? (0 or 1)\n4 Is CPO? (0 or 1)\n5 Is OEMCPO? (0 or 1)\n6 Savings amount\n7 Owner Count\n8 Is the car new? (0 or 1)\n9 Description\n10 Major Options\n11 Dealership Username\n12 Dealer ZIP\n13 Latitude\n14 Longitude\n15 Seller Rating\n16 Franchise Dealer? (0 or 1)")
        param = input()
        if param == "create":
            break

        if param in optionalInfo:
            column = optionalInfo[param]
            print("Value:")
            ans = input()
            optionalAns[column] = ans
        else:
            err()

    # Build SQL query
    query = ""
    for table in tables:
        columns = table.req[0]
        values = "'" + requiredAns[table.req[0]] + "'"
        for i in range(1,len(table.req)):
            columns += ", " + table.req[i]
            values += ", '" + requiredAns[table.req[i]] + "'"

        for opt in table.opt:
            if opt in optionalAns:
                columns += ", " + opt
                values += ", '" + optionalAns[opt] + "'"

        query += "INSERT "
        if table.ignore:
            query += "IGNORE "
        query += "INTO " + table.name + "(" + columns + ") " + "VALUES (" + values + ")" + ";"

    return query
    


def modify():
    print("Listing ID to modify:")
    listingID = input().lower()
    print("Select a number(s) and specify what you want to modify. Type \"Modify\" to modify the listing ID")

    modifyMap = {
        "1" : "is_certified",
        "2" : "is_cpo",
        "3" : "is_oemcpo",
        "4" : "savings_amount",
        "5" : "price",
        "6" : "owner_count",
        "7" : "is_new",
        "8" : "description",
        "9" : "major_options"
    }
    modifyAns = {}
    while True:
        print("1 Certified? (0,1)\n2 Cpo? (0,1)\n3 Oemcpo? (0,1)\n4 Savings Amount\n5 Price\n6 Owner Count\n7 New? (0,1)\n8 Description\n9 Major Options")
        param = input().lower()
        if param == "modify":
            break

        if param in modifyMap:
            column = modifyMap[param]
            print("New Value:")
            ans = input()
            modifyAns[column] = ans
            print(column + " section updated")
        else:
            err()

    #print(listingID, modifyAns)
    
    empty = ""
    if not modifyAns:
        return empty
    
    query = "UPDATE listing SET " 

    count = 0
    for k,v in modifyAns.items():
        if count:
            query += ", "
        query += k + "=" + "'" + v + "'"
        count += 1
    
    query += " WHERE listing_id=" + listingID +";"
    return query


def delete():
    print("Listing ID:")
    listingID = input()

    print("Deleting: " + listingID)
    query = "DELETE FROM listing WHERE listing_id=" + listingID
    return query

def main():
    # Connection to database and test query
    # host = "marmoset04.shoshin.uwaterloo.ca",
    # user = "zj2yan",
    # passwd = "Simon_123",
    # database = "NHL_356"
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="dsad",
        database="cars",
        autocommit=True
    )

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
        db.reconnect()
        cur = db.cursor()
        while True:
            print("What do you want to do? (Search, Create, Modify, Delete, Exit)")
            action = input().lower()
            if action=="exit":
                return
            if action in actions:
                break
            err()

        query = actions[action]()

        # Execute query
        cur.execute(query)
        
        
        
        df = pd.DataFrame(cur, columns=cur.column_names)
        if(df.size==0):
            print("No results.")            
        print(df)
        cur.close()
        print("\n\n\n")




if __name__ == "__main__":
    main()
