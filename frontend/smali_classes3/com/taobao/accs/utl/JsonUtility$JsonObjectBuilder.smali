.class public Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/utl/JsonUtility;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "JsonObjectBuilder"
.end annotation


# instance fields
.field jObject:Lorg/json/JSONObject;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 67
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    return-void
.end method


# virtual methods
.method public build()Lorg/json/JSONObject;
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    return-object v0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Boolean;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;
    .locals 1

    if-nez p2, :cond_0

    return-object p0

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    .line 96
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Integer;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;
    .locals 1

    if-nez p2, :cond_0

    return-object p0

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    .line 85
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Long;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;
    .locals 1

    if-nez p2, :cond_0

    return-object p0

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    .line 107
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;
    .locals 1

    if-eqz p2, :cond_0

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    .line 73
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-object p0
.end method

.method public put(Ljava/lang/String;Lorg/json/JSONArray;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;
    .locals 1

    if-nez p2, :cond_0

    return-object p0

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->jObject:Lorg/json/JSONObject;

    .line 119
    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p0
.end method
