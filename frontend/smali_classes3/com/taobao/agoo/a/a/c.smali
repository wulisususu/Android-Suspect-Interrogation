.class public Lcom/taobao/agoo/a/a/c;
.super Lcom/taobao/agoo/a/a/b;
.source "Taobao"


# static fields
.field public static final JSON_CMD_REGISTER:Ljava/lang/String; = "register"


# instance fields
.field public a:Ljava/lang/String;

.field public b:Ljava/lang/String;

.field public c:Ljava/lang/String;

.field public d:Ljava/lang/String;

.field public f:Ljava/lang/String;

.field public g:Ljava/lang/String;

.field public h:Ljava/lang/String;

.field public i:Ljava/lang/String;

.field public j:Ljava/lang/String;

.field public k:Ljava/lang/String;

.field public l:Ljava/lang/String;

.field public m:Ljava/lang/String;

.field public n:Ljava/lang/String;

.field public o:Ljava/lang/String;

.field public p:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Lcom/taobao/agoo/a/a/b;-><init>()V

    const/16 v0, 0xde

    .line 22
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/agoo/a/a/c;->d:Ljava/lang/String;

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 9

    const-string v0, "RegisterDO"

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 74
    :try_start_0
    invoke-static {p0}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 75
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    .line 76
    invoke-static {p0}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    move-result-object v6

    invoke-virtual {v6}, Lcom/taobao/accs/client/GlobalClientInfo;->getPackageInfo()Landroid/content/pm/PackageInfo;

    move-result-object v6

    iget-object v6, v6, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    .line 77
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_1

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_1

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_0

    goto :goto_0

    .line 81
    :cond_0
    new-instance v7, Lcom/taobao/agoo/a/a/c;

    invoke-direct {v7}, Lcom/taobao/agoo/a/a/c;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    const-string v8, "register"

    .line 82
    iput-object v8, v7, Lcom/taobao/agoo/a/a/c;->e:Ljava/lang/String;

    iput-object p1, v7, Lcom/taobao/agoo/a/a/c;->a:Ljava/lang/String;

    iput-object v4, v7, Lcom/taobao/agoo/a/a/c;->b:Ljava/lang/String;

    iput-object v6, v7, Lcom/taobao/agoo/a/a/c;->c:Ljava/lang/String;

    iput-object p2, v7, Lcom/taobao/agoo/a/a/c;->f:Ljava/lang/String;

    iput-object v5, v7, Lcom/taobao/agoo/a/a/c;->g:Ljava/lang/String;

    .line 88
    sget-object p1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    iput-object p1, v7, Lcom/taobao/agoo/a/a/c;->j:Ljava/lang/String;

    .line 89
    sget-object p1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    iput-object p1, v7, Lcom/taobao/agoo/a/a/c;->k:Ljava/lang/String;

    iput-object v3, v7, Lcom/taobao/agoo/a/a/c;->l:Ljava/lang/String;

    iput-object v3, v7, Lcom/taobao/agoo/a/a/c;->m:Ljava/lang/String;

    .line 92
    invoke-static {p0}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isNotificationEnabled(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v7, Lcom/taobao/agoo/a/a/c;->h:Ljava/lang/String;

    .line 93
    invoke-static {}, Lcom/taobao/accs/utl/RomInfoCollector;->getCollector()Lcom/taobao/accs/utl/RomInfoCollector;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/accs/utl/RomInfoCollector;->collect()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v7, Lcom/taobao/agoo/a/a/c;->i:Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p0

    goto :goto_1

    :cond_1
    :goto_0
    :try_start_2
    const-string p0, "buildRegister param null"

    const/4 p2, 0x6

    new-array p2, p2, [Ljava/lang/Object;

    const-string v5, "appKey"

    aput-object v5, p2, v1

    aput-object p1, p2, v2

    const-string p1, "utdid"

    const/4 v5, 0x2

    aput-object p1, p2, v5

    const/4 p1, 0x3

    aput-object v4, p2, p1

    const-string p1, "appVersion"

    const/4 v4, 0x4

    aput-object p1, p2, v4

    const/4 p1, 0x5

    aput-object v6, p2, p1

    .line 78
    invoke-static {v0, p0, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    return-object v3

    :catchall_1
    move-exception p0

    move-object v7, v3

    :goto_1
    :try_start_3
    const-string p1, "buildRegister"

    new-array p2, v2, [Ljava/lang/Object;

    .line 95
    invoke-virtual {p0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p0

    aput-object p0, p2, v1

    invoke-static {v0, p1, p2}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-eqz v7, :cond_2

    .line 98
    :goto_2
    invoke-virtual {v7}, Lcom/taobao/agoo/a/a/c;->a()[B

    move-result-object v3

    :cond_2
    return-object v3

    :catchall_2
    move-exception p0

    if-eqz v7, :cond_3

    invoke-virtual {v7}, Lcom/taobao/agoo/a/a/c;->a()[B

    .line 100
    :cond_3
    throw p0
.end method


# virtual methods
.method public a()[B
    .locals 6

    const-string v0, "buildData"

    const-string v1, "RegisterDO"

    const/4 v2, 0x0

    .line 43
    :try_start_0
    new-instance v3, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    invoke-direct {v3}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;-><init>()V

    const-string v4, "cmd"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->e:Ljava/lang/String;

    .line 44
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "appKey"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->a:Ljava/lang/String;

    .line 45
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "utdid"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->b:Ljava/lang/String;

    .line 46
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "appVersion"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->c:Ljava/lang/String;

    .line 47
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "sdkVersion"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->d:Ljava/lang/String;

    .line 48
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "ttid"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->f:Ljava/lang/String;

    .line 49
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "packageName"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->g:Ljava/lang/String;

    .line 50
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "notifyEnable"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->h:Ljava/lang/String;

    .line 51
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "romInfo"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->i:Ljava/lang/String;

    .line 52
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c0"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->j:Ljava/lang/String;

    .line 53
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c1"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->k:Ljava/lang/String;

    .line 54
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c2"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->l:Ljava/lang/String;

    .line 55
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c3"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->m:Ljava/lang/String;

    .line 56
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c4"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->n:Ljava/lang/String;

    .line 57
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c5"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->o:Ljava/lang/String;

    .line 58
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    const-string v4, "c6"

    iget-object v5, p0, Lcom/taobao/agoo/a/a/c;->p:Ljava/lang/String;

    .line 59
    invoke-virtual {v3, v4, v5}, Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/utl/JsonUtility$JsonObjectBuilder;

    move-result-object v3

    .line 60
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

    .line 61
    invoke-static {v1, v0, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v4, "utf-8"

    .line 62
    invoke-virtual {v3, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v3

    new-array v2, v2, [Ljava/lang/Object;

    .line 64
    invoke-static {v1, v0, v3, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method
