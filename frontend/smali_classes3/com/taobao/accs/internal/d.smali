.class public abstract Lcom/taobao/accs/internal/d;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/taobao/accs/base/IBaseService;


# static fields
.field protected static a:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/net/b;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private b:Landroid/content/Context;

.field private c:Landroid/app/Service;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 27
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(I)V

    sput-object v0, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method public constructor <init>(Landroid/app/Service;)V
    .locals 0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/accs/internal/d;->c:Landroid/app/Service;

    .line 31
    invoke-virtual {p1}, Landroid/app/Service;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/internal/d;->b:Landroid/content/Context;

    return-void
.end method

.method protected static a(Landroid/content/Context;Ljava/lang/String;Z)Lcom/taobao/accs/net/b;
    .locals 10

    const-string v0, "configTag"

    const-string v1, "getConnection"

    const-string v2, "ElectionServiceImpl"

    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 125
    :try_start_0
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    const/4 v6, 0x1

    const/4 v7, 0x2

    if-eqz v5, :cond_1

    const-string p0, "getConnection configTag null or env invalid"

    new-array p1, v7, [Ljava/lang/Object;

    const-string p2, "conns.size"

    aput-object p2, p1, v3

    sget-object p2, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 126
    invoke-virtual {p2}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    aput-object p2, p1, v6

    invoke-static {v2, p0, p1}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    sget-object p0, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 127
    invoke-virtual {p0}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result p0

    if-lez p0, :cond_0

    sget-object p0, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 128
    invoke-virtual {p0}, Ljava/util/concurrent/ConcurrentHashMap;->elements()Ljava/util/Enumeration;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/taobao/accs/net/b;

    move-object v4, p0

    :cond_0
    return-object v4

    :cond_1
    const/4 v5, 0x4

    new-array v5, v5, [Ljava/lang/Object;

    aput-object v0, v5, v3

    aput-object p1, v5, v6

    const-string v8, "start"

    aput-object v8, v5, v7

    .line 132
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    const/4 v9, 0x3

    aput-object v8, v5, v9

    invoke-static {v2, v1, v5}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 133
    invoke-static {p1}, Lcom/taobao/accs/AccsClientConfig;->getConfigByTag(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig;

    move-result-object v5

    if-eqz v5, :cond_2

    .line 134
    invoke-virtual {v5}, Lcom/taobao/accs/AccsClientConfig;->getDisableChannel()Z

    move-result v5

    if-eqz v5, :cond_2

    const-string p0, "getConnection channel disabled!"

    new-array p2, v7, [Ljava/lang/Object;

    aput-object v0, p2, v3

    aput-object p1, p2, v6

    .line 135
    invoke-static {v2, p0, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v4

    .line 138
    :cond_2
    invoke-static {}, Lcom/taobao/accs/utl/Utils;->getMode()I

    move-result v0

    .line 139
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v6, "|"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 140
    invoke-virtual {v6, v5}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/taobao/accs/net/b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v6, :cond_5

    .line 142
    :try_start_1
    sput v0, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    .line 143
    new-instance v4, Lcom/taobao/accs/net/w;

    invoke-direct {v4, p0, v3, p1}, Lcom/taobao/accs/net/w;-><init>(Landroid/content/Context;ILjava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz p2, :cond_3

    .line 145
    :try_start_2
    invoke-virtual {v4}, Lcom/taobao/accs/net/b;->a()V

    :cond_3
    sget-object p0, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 147
    invoke-virtual {p0}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result p0

    const/16 p1, 0xa

    if-ge p0, p1, :cond_4

    sget-object p0, Lcom/taobao/accs/internal/d;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 148
    invoke-virtual {p0, v5, v4}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_4
    const-string p0, "getConnection fail as exist too many conns!!!"

    new-array p1, v3, [Ljava/lang/Object;

    .line 150
    invoke-static {v2, p0, p1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_1

    :catchall_0
    move-exception p0

    move-object v4, v6

    goto :goto_0

    :catchall_1
    move-exception p0

    :goto_0
    new-array p1, v3, [Ljava/lang/Object;

    .line 154
    invoke-static {v2, v1, p0, p1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_1
    move-object v6, v4

    :cond_5
    return-object v6
.end method

.method private a(Z)V
    .locals 5

    .line 109
    invoke-static {}, Lcom/taobao/accs/AccsClientConfig;->tags()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 111
    :try_start_0
    invoke-static {v1}, Lcom/taobao/accs/AccsClientConfig;->getConfigByTag(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig;

    move-result-object v2

    .line 112
    invoke-virtual {v2}, Lcom/taobao/accs/AccsClientConfig;->getDisableChannel()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/taobao/accs/internal/d;->b:Landroid/content/Context;

    .line 113
    invoke-static {v2, v1, p1}, Lcom/taobao/accs/internal/d;->a(Landroid/content/Context;Ljava/lang/String;Z)Lcom/taobao/accs/net/b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v2

    .line 116
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "tryStartAllConnections "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    const-string v4, "ElectionServiceImpl"

    invoke-static {v4, v1, v2, v3}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private b(Landroid/content/Intent;)V
    .locals 17

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    const-string v2, "ttid"

    const-string v3, "handleStartCommand"

    const-string v4, "configTag"

    const-string v5, "ElectionServiceImpl"

    const/4 v6, 0x0

    :try_start_0
    const-string v7, "packageName"

    .line 85
    invoke-virtual {v0, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "appKey"

    .line 86
    invoke-virtual {v0, v8}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 87
    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "app_sercet"

    .line 88
    invoke-virtual {v0, v10}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 89
    invoke-virtual {v0, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    const-string v12, "mode"

    .line 90
    invoke-virtual {v0, v12, v6}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    const/16 v12, 0xa

    new-array v12, v12, [Ljava/lang/Object;

    aput-object v4, v12, v6

    const/4 v13, 0x1

    aput-object v11, v12, v13

    const-string v14, "appkey"

    const/4 v15, 0x2

    aput-object v14, v12, v15

    const/4 v14, 0x3

    aput-object v8, v12, v14

    const-string v14, "appSecret"

    const/16 v16, 0x4

    aput-object v14, v12, v16

    const/4 v14, 0x5

    aput-object v10, v12, v14

    const/4 v10, 0x6

    aput-object v2, v12, v10

    const/4 v2, 0x7

    aput-object v9, v12, v2

    const-string v2, "pkg"

    const/16 v10, 0x8

    aput-object v2, v12, v10

    const/16 v2, 0x9

    aput-object v7, v12, v2

    .line 91
    invoke-static {v5, v3, v12}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 92
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, v1, Lcom/taobao/accs/internal/d;->b:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v7, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 93
    invoke-static {v0}, Lcom/taobao/accs/utl/Utils;->setMode(I)V

    iget-object v0, v1, Lcom/taobao/accs/internal/d;->b:Landroid/content/Context;

    .line 94
    invoke-static {v0, v11, v6}, Lcom/taobao/accs/internal/d;->a(Landroid/content/Context;Ljava/lang/String;Z)Lcom/taobao/accs/net/b;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 96
    iput-object v9, v0, Lcom/taobao/accs/net/b;->a:Ljava/lang/String;

    goto :goto_0

    :cond_0
    const-string v0, "handleStartCommand start action, no connection"

    new-array v2, v15, [Ljava/lang/Object;

    aput-object v4, v2, v6

    aput-object v11, v2, v13

    .line 98
    invoke-static {v5, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    iget-object v0, v1, Lcom/taobao/accs/internal/d;->b:Landroid/content/Context;

    .line 100
    invoke-static {v0, v8}, Lcom/taobao/accs/utl/UtilityImpl;->e(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    new-array v2, v6, [Ljava/lang/Object;

    .line 103
    invoke-static {v5, v3, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_1
    return-void
.end method


# virtual methods
.method public abstract a(Landroid/content/Intent;)I
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 3

    const/16 v0, 0xde

    .line 36
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, "sdkVersion"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ElectionServiceImpl"

    const-string v2, "onCreate,"

    invoke-static {v1, v2, v0}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public onDestroy()V
    .locals 3

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "ElectionServiceImpl"

    const-string v2, "Service onDestroy"

    .line 73
    invoke-static {v1, v2, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/accs/internal/d;->b:Landroid/content/Context;

    iput-object v0, p0, Lcom/taobao/accs/internal/d;->c:Landroid/app/Service;

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x2

    return p1

    .line 45
    :cond_0
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    const-string p3, "action"

    .line 46
    filled-new-array {p3, p2}, [Ljava/lang/Object;

    move-result-object p3

    const-string v0, "ElectionServiceImpl"

    const-string v1, "onStartCommand begin"

    invoke-static {v0, v1, p3}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string p3, "com.taobao.accs.intent.action.START_SERVICE"

    .line 49
    invoke-static {p2, p3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result p3

    if-eqz p3, :cond_1

    .line 50
    invoke-direct {p0, p1}, Lcom/taobao/accs/internal/d;->b(Landroid/content/Intent;)V

    goto :goto_0

    .line 51
    :cond_1
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-eqz p2, :cond_2

    const/4 p2, 0x1

    .line 53
    invoke-direct {p0, p2}, Lcom/taobao/accs/internal/d;->a(Z)V

    goto :goto_0

    :cond_2
    const/4 p2, 0x0

    .line 56
    invoke-direct {p0, p2}, Lcom/taobao/accs/internal/d;->a(Z)V

    .line 58
    :goto_0
    invoke-virtual {p0, p1}, Lcom/taobao/accs/internal/d;->a(Landroid/content/Intent;)I

    move-result p1

    return p1
.end method

.method public onUnbind(Landroid/content/Intent;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
