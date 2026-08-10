.class public Lcom/taobao/monitor/procedure/Value;
.super Ljava/lang/Object;
.source "Value.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "Value"


# instance fields
.field private bizIndex:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/monitor/procedure/model/Biz;",
            ">;"
        }
    .end annotation
.end field

.field private bizs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/model/Biz;",
            ">;"
        }
    .end annotation
.end field

.field private counters:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private events:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/model/Event;",
            ">;"
        }
    .end annotation
.end field

.field private final independent:Z

.field private final parentNeedStats:Z

.field private properties:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private final simpleTopic:Ljava/lang/String;

.field private stages:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/model/Stage;",
            ">;"
        }
    .end annotation
.end field

.field private statistics:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private subValues:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/Value;",
            ">;"
        }
    .end annotation
.end field

.field private timestamp:J

.field private final topic:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;ZZ)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0
        }
        names = {
            "topic",
            "independent",
            "parentNeedStats"
        }
    .end annotation

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/procedure/Value;->timestamp:J

    iput-object p1, p0, Lcom/taobao/monitor/procedure/Value;->topic:Ljava/lang/String;

    const-string v0, "/"

    .line 58
    invoke-virtual {p1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 59
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v0, v0, 0x1

    if-le v1, v0, :cond_0

    .line 60
    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/procedure/Value;->simpleTopic:Ljava/lang/String;

    goto :goto_0

    :cond_0
    iput-object p1, p0, Lcom/taobao/monitor/procedure/Value;->simpleTopic:Ljava/lang/String;

    :goto_0
    iput-boolean p2, p0, Lcom/taobao/monitor/procedure/Value;->independent:Z

    iput-boolean p3, p0, Lcom/taobao/monitor/procedure/Value;->parentNeedStats:Z

    .line 67
    invoke-direct {p0}, Lcom/taobao/monitor/procedure/Value;->initialize()V

    return-void
.end method

.method private initialize()V
    .locals 1

    .line 71
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->subValues:Ljava/util/List;

    .line 72
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->events:Ljava/util/List;

    .line 73
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    .line 74
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->statistics:Ljava/util/Map;

    .line 75
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 76
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->properties:Ljava/util/Map;

    .line 77
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 78
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method addBiz(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/Value;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "bizId",
            "properties"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/Value;"
        }
    .end annotation

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    .line 125
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/procedure/model/Biz;

    if-nez v0, :cond_0

    .line 127
    new-instance v0, Lcom/taobao/monitor/procedure/model/Biz;

    invoke-direct {v0, p1, p2}, Lcom/taobao/monitor/procedure/model/Biz;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    .line 128
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 129
    monitor-enter p1

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 130
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 131
    monitor-exit p1

    goto :goto_0

    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p2

    .line 134
    :cond_0
    :goto_0
    invoke-virtual {v0, p2}, Lcom/taobao/monitor/procedure/model/Biz;->addProperties(Ljava/util/Map;)Lcom/taobao/monitor/procedure/model/Biz;

    :cond_1
    return-object p0
.end method

.method addBizAbTest(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/Value;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "bizId",
            "abTest"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/Value;"
        }
    .end annotation

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    .line 144
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/procedure/model/Biz;

    if-nez v0, :cond_0

    .line 146
    new-instance v0, Lcom/taobao/monitor/procedure/model/Biz;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/taobao/monitor/procedure/model/Biz;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    .line 147
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 148
    monitor-enter p1

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 149
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 150
    monitor-exit p1

    goto :goto_0

    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p2

    .line 153
    :cond_0
    :goto_0
    invoke-virtual {v0, p2}, Lcom/taobao/monitor/procedure/model/Biz;->addAbTest(Ljava/util/Map;)Lcom/taobao/monitor/procedure/model/Biz;

    :cond_1
    return-object p0
.end method

.method addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/Value;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "bizId",
            "stage"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/Value;"
        }
    .end annotation

    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    .line 162
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/procedure/model/Biz;

    if-nez v0, :cond_0

    .line 164
    new-instance v0, Lcom/taobao/monitor/procedure/model/Biz;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/taobao/monitor/procedure/model/Biz;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->bizIndex:Ljava/util/Map;

    .line 165
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 166
    monitor-enter p1

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    .line 167
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 168
    monitor-exit p1

    goto :goto_0

    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p2

    .line 171
    :cond_0
    :goto_0
    invoke-virtual {v0, p2}, Lcom/taobao/monitor/procedure/model/Biz;->addStage(Ljava/util/Map;)Lcom/taobao/monitor/procedure/model/Biz;

    :cond_1
    return-object p0
.end method

.method addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/Value;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "key",
            "value"
        }
    .end annotation

    if-eqz p2, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->properties:Ljava/util/Map;

    .line 110
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    :goto_0
    return-object p0
.end method

.method addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/Value;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "key",
            "value"
        }
    .end annotation

    if-eqz p2, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->statistics:Ljava/util/Map;

    .line 118
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    :goto_0
    return-object p0
.end method

.method addSubValue(Lcom/taobao/monitor/procedure/Value;)Lcom/taobao/monitor/procedure/Value;
    .locals 7
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subValue"
        }
    .end annotation

    if-eqz p1, :cond_6

    .line 182
    iget-object v0, p1, Lcom/taobao/monitor/procedure/Value;->simpleTopic:Ljava/lang/String;

    .line 183
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object p0

    :cond_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 187
    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    const/4 v2, 0x1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 189
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    iget-object v3, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 191
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    add-int/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v3, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 194
    :goto_0
    iget-boolean v1, p1, Lcom/taobao/monitor/procedure/Value;->parentNeedStats:Z

    if-eqz v1, :cond_4

    .line 195
    iget-object v1, p1, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    .line 196
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/taobao/monitor/procedure/model/Stage;

    .line 197
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/model/Stage;->name()Ljava/lang/String;

    move-result-object v3

    .line 198
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v3

    const/4 v4, 0x0

    .line 199
    aget-char v5, v3, v4

    const/16 v6, 0x61

    if-lt v5, v6, :cond_2

    add-int/lit8 v5, v5, -0x20

    int-to-char v5, v5

    .line 201
    aput-char v5, v3, v4

    .line 203
    :cond_2
    invoke-static {v3}, Ljava/lang/String;->valueOf([C)Ljava/lang/String;

    move-result-object v3

    .line 204
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 205
    invoke-interface {v4, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    if-nez v4, :cond_3

    iget-object v4, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 207
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-interface {v4, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_3
    iget-object v5, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    .line 209
    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    add-int/2addr v4, v2

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v5, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->subValues:Ljava/util/List;

    .line 214
    monitor-enter v0

    .line 216
    :try_start_0
    iget-boolean v1, p1, Lcom/taobao/monitor/procedure/Value;->independent:Z

    if-nez v1, :cond_5

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->subValues:Ljava/util/List;

    .line 217
    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 219
    :cond_5
    monitor-exit v0

    goto :goto_2

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_6
    :goto_2
    return-object p0
.end method

.method public bizs()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/model/Biz;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->bizs:Ljava/util/List;

    return-object v0
.end method

.method public counters()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->counters:Ljava/util/Map;

    return-object v0
.end method

.method event(Lcom/taobao/monitor/procedure/model/Event;)Lcom/taobao/monitor/procedure/Value;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "event"
        }
    .end annotation

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->events:Ljava/util/List;

    .line 88
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->events:Ljava/util/List;

    .line 89
    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 90
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-object p0
.end method

.method public events()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/model/Event;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->events:Ljava/util/List;

    return-object v0
.end method

.method public properties()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->properties:Ljava/util/Map;

    return-object v0
.end method

.method removeSubValue(Lcom/taobao/monitor/procedure/Value;)Lcom/taobao/monitor/procedure/Value;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subValue"
        }
    .end annotation

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->subValues:Ljava/util/List;

    .line 226
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->subValues:Ljava/util/List;

    .line 227
    invoke-interface {v1, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 228
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-object p0
.end method

.method stage(Lcom/taobao/monitor/procedure/model/Stage;)Lcom/taobao/monitor/procedure/Value;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "stage"
        }
    .end annotation

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    .line 98
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    .line 99
    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 100
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-object p0
.end method

.method public stages()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/model/Stage;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    return-object v0
.end method

.method public statistics()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->statistics:Ljava/util/Map;

    return-object v0
.end method

.method public subValues()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/Value;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->subValues:Ljava/util/List;

    return-object v0
.end method

.method summary()Lcom/taobao/monitor/procedure/Value;
    .locals 4

    .line 234
    new-instance v0, Lcom/taobao/monitor/procedure/Value;

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->simpleTopic:Ljava/lang/String;

    iget-boolean v2, p0, Lcom/taobao/monitor/procedure/Value;->independent:Z

    iget-boolean v3, p0, Lcom/taobao/monitor/procedure/Value;->parentNeedStats:Z

    invoke-direct {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/Value;-><init>(Ljava/lang/String;ZZ)V

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    iput-object v1, v0, Lcom/taobao/monitor/procedure/Value;->stages:Ljava/util/List;

    iget-object v1, p0, Lcom/taobao/monitor/procedure/Value;->properties:Ljava/util/Map;

    iput-object v1, v0, Lcom/taobao/monitor/procedure/Value;->properties:Ljava/util/Map;

    return-object v0
.end method

.method public timestamp()J
    .locals 2

    iget-wide v0, p0, Lcom/taobao/monitor/procedure/Value;->timestamp:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->topic:Ljava/lang/String;

    return-object v0
.end method

.method public topic()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/Value;->topic:Ljava/lang/String;

    return-object v0
.end method
