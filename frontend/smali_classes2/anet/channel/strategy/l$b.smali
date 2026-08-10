.class public Lanet/channel/strategy/l$b;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/strategy/l;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "b"
.end annotation


# instance fields
.field public final a:Ljava/lang/String;

.field public final b:I

.field public final c:Ljava/lang/String;

.field public final d:Ljava/lang/String;

.field public final e:Ljava/lang/String;

.field public final f:[Ljava/lang/String;

.field public final g:[Ljava/lang/String;

.field public final h:[Lanet/channel/strategy/l$a;

.field public final i:[Lanet/channel/strategy/l$e;

.field public final j:Z

.field public final k:Z

.field public final l:I


# direct methods
.method public constructor <init>(Lorg/json/JSONObject;)V
    .locals 8

    .line 93
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "host"

    .line 94
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    const-string v0, "ttl"

    .line 95
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lanet/channel/strategy/l$b;->b:I

    const-string v0, "safeAisles"

    .line 96
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/l$b;->c:Ljava/lang/String;

    const-string v0, "cname"

    const/4 v1, 0x0

    .line 97
    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/l$b;->d:Ljava/lang/String;

    const-string v0, "unit"

    .line 98
    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/l$b;->e:Ljava/lang/String;

    const-string v0, "clear"

    .line 99
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v3, :cond_0

    goto :goto_0

    :cond_0
    move v3, v2

    :goto_0
    iput-boolean v3, p0, Lanet/channel/strategy/l$b;->j:Z

    const-string v0, "effectNow"

    .line 100
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, p0, Lanet/channel/strategy/l$b;->k:Z

    const-string v0, "version"

    .line 101
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lanet/channel/strategy/l$b;->l:I

    const-string v0, "ips"

    .line 103
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 105
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    .line 106
    new-array v4, v3, [Ljava/lang/String;

    iput-object v4, p0, Lanet/channel/strategy/l$b;->f:[Ljava/lang/String;

    move v4, v2

    :goto_1
    if-ge v4, v3, :cond_2

    iget-object v5, p0, Lanet/channel/strategy/l$b;->f:[Ljava/lang/String;

    .line 108
    invoke-virtual {v0, v4}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_1
    iput-object v1, p0, Lanet/channel/strategy/l$b;->f:[Ljava/lang/String;

    :cond_2
    const-string v0, "sips"

    .line 114
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 115
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-lez v3, :cond_3

    .line 116
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    .line 117
    new-array v4, v3, [Ljava/lang/String;

    iput-object v4, p0, Lanet/channel/strategy/l$b;->g:[Ljava/lang/String;

    move v4, v2

    :goto_2
    if-ge v4, v3, :cond_4

    iget-object v5, p0, Lanet/channel/strategy/l$b;->g:[Ljava/lang/String;

    .line 119
    invoke-virtual {v0, v4}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_3
    iput-object v1, p0, Lanet/channel/strategy/l$b;->g:[Ljava/lang/String;

    :cond_4
    const-string v0, "aisles"

    .line 125
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 127
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    .line 128
    new-array v4, v3, [Lanet/channel/strategy/l$a;

    iput-object v4, p0, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    move v4, v2

    :goto_3
    if-ge v4, v3, :cond_6

    iget-object v5, p0, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    .line 130
    new-instance v6, Lanet/channel/strategy/l$a;

    invoke-virtual {v0, v4}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v7

    invoke-direct {v6, v7}, Lanet/channel/strategy/l$a;-><init>(Lorg/json/JSONObject;)V

    aput-object v6, v5, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    :cond_5
    iput-object v1, p0, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    :cond_6
    const-string v0, "strategies"

    .line 136
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    if-eqz p1, :cond_7

    .line 137
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    if-lez v0, :cond_7

    .line 138
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    .line 139
    new-array v1, v0, [Lanet/channel/strategy/l$e;

    iput-object v1, p0, Lanet/channel/strategy/l$b;->i:[Lanet/channel/strategy/l$e;

    :goto_4
    if-ge v2, v0, :cond_8

    iget-object v1, p0, Lanet/channel/strategy/l$b;->i:[Lanet/channel/strategy/l$e;

    .line 141
    new-instance v3, Lanet/channel/strategy/l$e;

    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    invoke-direct {v3, v4}, Lanet/channel/strategy/l$e;-><init>(Lorg/json/JSONObject;)V

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_7
    iput-object v1, p0, Lanet/channel/strategy/l$b;->i:[Lanet/channel/strategy/l$e;

    :cond_8
    return-void
.end method
