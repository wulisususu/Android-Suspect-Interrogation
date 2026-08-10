.class public Lcom/taobao/agoo/a/a/d;
.super Lcom/taobao/agoo/a/a/b;
.source "Taobao"


# static fields
.field public static final JSON_CMD_DISABLEPUSH:Ljava/lang/String; = "disablePush"

.field public static final JSON_CMD_ENABLEPUSH:Ljava/lang/String; = "enablePush"


# instance fields
.field public a:Ljava/lang/String;

.field public b:Ljava/lang/String;

.field public c:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Lcom/taobao/agoo/a/a/b;-><init>()V

    return-void
.end method

.method public static a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)[B
    .locals 1

    .line 46
    new-instance v0, Lcom/taobao/agoo/a/a/d;

    invoke-direct {v0}, Lcom/taobao/agoo/a/a/d;-><init>()V

    iput-object p0, v0, Lcom/taobao/agoo/a/a/d;->a:Ljava/lang/String;

    iput-object p1, v0, Lcom/taobao/agoo/a/a/d;->b:Ljava/lang/String;

    iput-object p2, v0, Lcom/taobao/agoo/a/a/d;->c:Ljava/lang/String;

    if-eqz p3, :cond_0

    const-string p0, "enablePush"

    .line 51
    iput-object p0, v0, Lcom/taobao/agoo/a/a/d;->e:Ljava/lang/String;

    goto :goto_0

    :cond_0
    const-string p0, "disablePush"

    .line 53
    iput-object p0, v0, Lcom/taobao/agoo/a/a/d;->e:Ljava/lang/String;

    .line 55
    :goto_0
    invoke-virtual {v0}, Lcom/taobao/agoo/a/a/d;->a()[B

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public a()[B
    .locals 7

    const-string v0, "buildData"

    const-string v1, "SwitchDO"

    const/4 v2, 0x0

    .line 26
    :try_start_0
    new-instance v3, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    invoke-direct {v3}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;-><init>()V

    const-string v4, "cmd"

    .line 27
    iget-object v5, p0, Lcom/taobao/agoo/a/a/d;->e:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v4

    const-string v5, "appKey"

    iget-object v6, p0, Lcom/taobao/agoo/a/a/d;->a:Ljava/lang/String;

    .line 28
    invoke-virtual {v4, v5, v6}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    iget-object v4, p0, Lcom/taobao/agoo/a/a/d;->b:Ljava/lang/String;

    .line 30
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v4, "utdid"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/d;->c:Ljava/lang/String;

    .line 31
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    goto :goto_0

    :cond_0
    const-string v4, "deviceId"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/d;->b:Ljava/lang/String;

    .line 33
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    .line 35
    :goto_0
    invoke-virtual {v3}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->build()Lorg/json/JSONObject;

    move-result-object v3

    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "data"

    aput-object v5, v4, v2

    const/4 v5, 0x1

    aput-object v3, v4, v5

    .line 36
    invoke-static {v1, v0, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v4, "utf-8"

    .line 37
    invoke-virtual {v3, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v3

    new-array v2, v2, [Ljava/lang/Object;

    .line 39
    invoke-static {v1, v0, v3, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method
