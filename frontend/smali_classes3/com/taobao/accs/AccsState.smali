.class public Lcom/taobao/accs/AccsState;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/AccsState$b;,
        Lcom/taobao/accs/AccsState$c;,
        Lcom/taobao/accs/AccsState$a;
    }
.end annotation


# static fields
.field public static final ALL:Ljava/lang/String; = "all"

.field public static final BIND_APP_FROM_CACHE:Ljava/lang/String; = "bfc"

.field public static final CONNECTION_CHANGE:Ljava/lang/String; = "cc"

.field public static final LAST_MSG_RECEIVE_TIME:Ljava/lang/String; = "lmrt"

.field public static final LAST_MSG_SEND_TIME:Ljava/lang/String; = "lmst"

.field public static final RECENT_ERRORS:Ljava/lang/String; = "re"

.field public static final SDK_VERSION:Ljava/lang/String; = "sv"


# instance fields
.field private a:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/AccsState$c;",
            ">;"
        }
    .end annotation
.end field

.field private b:J

.field private c:J


# direct methods
.method protected constructor <init>()V
    .locals 2

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/taobao/accs/AccsState;->b:J

    iput-wide v0, p0, Lcom/taobao/accs/AccsState;->c:J

    return-void
.end method

.method private a(Ljava/lang/String;)Lcom/taobao/accs/AccsState$c;
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    .line 124
    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/accs/AccsState$c;

    if-nez v0, :cond_0

    .line 126
    new-instance v0, Lcom/taobao/accs/AccsState$c;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/accs/AccsState$c;-><init>(Lcom/taobao/accs/a;)V

    iget-object v1, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    .line 127
    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-object v0
.end method

.method private a()V
    .locals 4

    iget-wide v0, p0, Lcom/taobao/accs/AccsState;->c:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    iget-wide v0, p0, Lcom/taobao/accs/AccsState;->b:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    .line 134
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/accs/AccsState;->c:J

    .line 135
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/accs/AccsState;->b:J

    :cond_1
    return-void
.end method

.method private a(Ljava/util/HashMap;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/AccsState$c;",
            ">;)Z"
        }
    .end annotation

    .line 145
    invoke-virtual {p1}, Ljava/util/HashMap;->size()I

    move-result p1

    if-lez p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method private a(Ljava/util/HashMap;Ljava/lang/String;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/AccsState$c;",
            ">;",
            "Ljava/lang/String;",
            ")Z"
        }
    .end annotation

    .line 149
    new-instance v0, Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 150
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/accs/AccsState$c;

    .line 151
    invoke-virtual {v0, p2}, Lcom/taobao/accs/AccsState$c;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method private b()J
    .locals 4

    .line 140
    invoke-direct {p0}, Lcom/taobao/accs/AccsState;->a()V

    .line 141
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/taobao/accs/AccsState;->b:J

    sub-long/2addr v0, v2

    return-wide v0
.end method

.method public static getInstance()Lcom/taobao/accs/AccsState;
    .locals 1

    .line 31
    invoke-static {}, Lcom/taobao/accs/AccsState$a;->a()Lcom/taobao/accs/AccsState;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public declared-synchronized a(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "all"

    .line 56
    invoke-direct {p0, v0}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;)Lcom/taobao/accs/AccsState$c;

    move-result-object v0

    .line 57
    invoke-direct {p0}, Lcom/taobao/accs/AccsState;->b()J

    move-result-wide v1

    invoke-virtual {v0, p1, p2, v1, v2}, Lcom/taobao/accs/AccsState$c;->a(Ljava/lang/String;Ljava/lang/Object;J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 58
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 2

    monitor-enter p0

    .line 111
    :try_start_0
    invoke-direct {p0, p1}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;)Lcom/taobao/accs/AccsState$c;

    move-result-object p1

    .line 112
    invoke-direct {p0}, Lcom/taobao/accs/AccsState;->b()J

    move-result-wide v0

    invoke-virtual {p1, p2, p3, v0, v1}, Lcom/taobao/accs/AccsState$c;->a(Ljava/lang/String;Ljava/lang/Object;J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 113
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized b(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3

    monitor-enter p0

    :try_start_0
    const-string v0, "all"

    .line 64
    invoke-direct {p0, v0}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;)Lcom/taobao/accs/AccsState$c;

    move-result-object v0

    .line 65
    invoke-direct {p0}, Lcom/taobao/accs/AccsState;->b()J

    move-result-wide v1

    invoke-virtual {v0, p1, p2, v1, v2}, Lcom/taobao/accs/AccsState$c;->b(Ljava/lang/String;Ljava/lang/Object;J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 66
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 2

    monitor-enter p0

    .line 119
    :try_start_0
    invoke-direct {p0, p1}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;)Lcom/taobao/accs/AccsState$c;

    move-result-object p1

    .line 120
    invoke-direct {p0}, Lcom/taobao/accs/AccsState;->b()J

    move-result-wide v0

    invoke-virtual {p1, p2, p3, v0, v1}, Lcom/taobao/accs/AccsState$c;->b(Ljava/lang/String;Ljava/lang/Object;J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 121
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getState()Ljava/lang/String;
    .locals 4

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    .line 72
    invoke-direct {p0, v0}, Lcom/taobao/accs/AccsState;->a(Ljava/util/HashMap;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "{}"
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 73
    monitor-exit p0

    return-object v0

    .line 75
    :cond_0
    :try_start_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    const-string v1, "t"

    iget-wide v2, p0, Lcom/taobao/accs/AccsState;->c:J

    .line 77
    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 78
    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 79
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 80
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/accs/AccsState$c;

    invoke-virtual {v2}, Lcom/taobao/accs/AccsState$c;->a()Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    .line 83
    :try_start_3
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 85
    :cond_1
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    monitor-exit p0

    return-object v0

    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getStateByKey(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    .line 89
    invoke-direct {p0, v0, p1}, Lcom/taobao/accs/AccsState;->a(Ljava/util/HashMap;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string p1, "{}"
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 90
    monitor-exit p0

    return-object p1

    .line 92
    :cond_0
    :try_start_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    const-string v1, "t"

    iget-wide v2, p0, Lcom/taobao/accs/AccsState;->c:J

    .line 94
    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 95
    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/taobao/accs/AccsState;->a:Ljava/util/HashMap;

    invoke-virtual {v2}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 96
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 97
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/taobao/accs/AccsState$c;

    invoke-virtual {v3, p1}, Lcom/taobao/accs/AccsState$c;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 98
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/accs/AccsState$c;

    invoke-virtual {v2, p1}, Lcom/taobao/accs/AccsState$c;->b(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 102
    :try_start_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 104
    :cond_2
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    monitor-exit p0

    return-object p1

    :catchall_1
    move-exception p1

    monitor-exit p0

    throw p1
.end method
