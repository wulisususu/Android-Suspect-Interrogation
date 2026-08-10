.class public Lcom/taobao/accs/data/d;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field public a:Ljava/util/concurrent/ConcurrentMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentMap<",
            "Ljava/lang/String;",
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;>;"
        }
    .end annotation
.end field

.field public b:I

.field protected c:Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

.field public d:Lcom/taobao/accs/flowcontrol/FlowControl;

.field public e:Ljava/lang/String;

.field private f:Ljava/util/concurrent/ConcurrentMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentMap<",
            "Lcom/taobao/accs/data/Message$a;",
            "Lcom/taobao/accs/data/Message;",
            ">;"
        }
    .end annotation
.end field

.field private g:Z

.field private h:Landroid/content/Context;

.field private i:Lcom/taobao/accs/ut/a/d;

.field private j:Lcom/taobao/accs/data/Message;

.field private k:Lcom/taobao/accs/net/b;

.field private l:Ljava/lang/String;

.field private m:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private n:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/data/a;",
            ">;"
        }
    .end annotation
.end field

.field private o:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/taobao/accs/net/b;)V
    .locals 1

    .line 97
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 67
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/data/d;->a:Ljava/util/concurrent/ConcurrentMap;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/data/d;->g:Z

    const-string v0, ""

    iput-object v0, p0, Lcom/taobao/accs/data/d;->e:Ljava/lang/String;

    const-string v0, "MsgRecv_"

    iput-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 89
    new-instance v0, Lcom/taobao/accs/data/MessageHandler$1;

    invoke-direct {v0, p0}, Lcom/taobao/accs/data/MessageHandler$1;-><init>(Lcom/taobao/accs/data/d;)V

    iput-object v0, p0, Lcom/taobao/accs/data/d;->m:Ljava/util/LinkedHashMap;

    .line 863
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/data/d;->n:Ljava/util/Map;

    .line 1066
    new-instance v0, Lcom/taobao/accs/data/f;

    invoke-direct {v0, p0}, Lcom/taobao/accs/data/f;-><init>(Lcom/taobao/accs/data/d;)V

    iput-object v0, p0, Lcom/taobao/accs/data/d;->o:Ljava/lang/Runnable;

    iput-object p1, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    iput-object p2, p0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 100
    new-instance p1, Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

    iget-object v0, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    invoke-direct {p1, v0}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/taobao/accs/data/d;->c:Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

    .line 101
    new-instance p1, Lcom/taobao/accs/flowcontrol/FlowControl;

    iget-object v0, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    invoke-direct {p1, v0}, Lcom/taobao/accs/flowcontrol/FlowControl;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/taobao/accs/data/d;->d:Lcom/taobao/accs/flowcontrol/FlowControl;

    if-nez p2, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    goto :goto_0

    .line 102
    :cond_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object p2, p2, Lcom/taobao/accs/net/b;->m:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 103
    invoke-direct {p0}, Lcom/taobao/accs/data/d;->i()V

    .line 104
    invoke-virtual {p0}, Lcom/taobao/accs/data/d;->h()V

    return-void
.end method

.method private a(Lcom/taobao/accs/utl/h;)Ljava/util/Map;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/taobao/accs/utl/h;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const-string v0, "extHeaderLen:"

    const/4 v1, 0x0

    if-nez p1, :cond_0

    return-object v1

    :cond_0
    const/4 v2, 0x0

    .line 550
    :try_start_0
    invoke-virtual {p1}, Lcom/taobao/accs/utl/h;->b()I

    move-result v3

    .line 551
    sget-object v4, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v4}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 552
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v5, v2, [Ljava/lang/Object;

    invoke-static {v4, v0, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    move v0, v2

    :cond_2
    :goto_0
    if-ge v0, v3, :cond_4

    .line 557
    invoke-virtual {p1}, Lcom/taobao/accs/utl/h;->b()I

    move-result v4

    add-int/lit8 v0, v0, 0x2

    const v5, 0xfc00

    and-int/2addr v5, v4

    shr-int/lit8 v5, v5, 0xa

    and-int/lit16 v4, v4, 0x3ff

    .line 561
    invoke-virtual {p1, v4}, Lcom/taobao/accs/utl/h;->a(I)Ljava/lang/String;

    move-result-object v6

    add-int/2addr v0, v4

    if-nez v1, :cond_3

    .line 564
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    move-object v1, v4

    .line 566
    :cond_3
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v1, v4, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 569
    sget-object v4, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v4}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v7, ""

    const/4 v8, 0x4

    new-array v8, v8, [Ljava/lang/Object;

    const-string v9, "extHeaderType"

    aput-object v9, v8, v2

    .line 570
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/4 v9, 0x1

    aput-object v5, v8, v9

    const-string v5, "value"

    const/4 v9, 0x2

    aput-object v5, v8, v9

    const/4 v5, 0x3

    aput-object v6, v8, v5

    invoke-static {v4, v7, v8}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v3, "parseExtHeader"

    new-array v2, v2, [Ljava/lang/Object;

    .line 574
    invoke-static {v0, v3, p1, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_4
    return-object v1
.end method

.method private a(I[BLjava/lang/String;I)V
    .locals 46
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    move-object/from16 v7, p0

    move/from16 v8, p1

    move-object/from16 v9, p2

    move-object/from16 v14, p3

    const-string v15, "1"

    const-string v13, "send_fail"

    const-string v12, "accs"

    const-string v11, ""

    const-string v10, "1commandId=101serviceId="

    const-string v6, "serviceId="

    const-string v1, "data:"

    const-string v0, "oriData:"

    const-string v2, "binary "

    .line 170
    new-instance v3, Lcom/taobao/accs/utl/h;

    invoke-direct {v3, v9}, Lcom/taobao/accs/utl/h;-><init>([B)V

    .line 171
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->b()I

    move-result v4

    int-to-long v4, v4

    .line 172
    sget-object v16, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static/range {v16 .. v16}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v16

    move-object/from16 v17, v15

    if-eqz v16, :cond_0

    iget-object v15, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    move-object/from16 v18, v6

    .line 173
    new-instance v6, Ljava/lang/StringBuilder;

    move-object/from16 v19, v13

    const-string v13, "flag:"

    invoke-direct {v6, v13}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    long-to-int v13, v4

    invoke-static {v13}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object/from16 v20, v10

    const/4 v13, 0x0

    new-array v10, v13, [Ljava/lang/Object;

    invoke-static {v15, v6, v10}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    move-object/from16 v18, v6

    move-object/from16 v20, v10

    move-object/from16 v19, v13

    .line 175
    :goto_0
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->a()I

    move-result v6

    invoke-virtual {v3, v6}, Lcom/taobao/accs/utl/h;->a(I)Ljava/lang/String;

    move-result-object v10

    .line 176
    sget-object v6, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v6}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v6

    if-eqz v6, :cond_1

    iget-object v6, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 177
    new-instance v13, Ljava/lang/StringBuilder;

    const-string v15, "target:"

    invoke-direct {v13, v15}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    move-object/from16 v21, v12

    const/4 v15, 0x0

    new-array v12, v15, [Ljava/lang/Object;

    invoke-static {v6, v13, v12}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    :cond_1
    move-object/from16 v21, v12

    .line 179
    :goto_1
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->a()I

    move-result v6

    invoke-virtual {v3, v6}, Lcom/taobao/accs/utl/h;->a(I)Ljava/lang/String;

    move-result-object v12

    .line 180
    sget-object v6, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v6}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v6

    if-eqz v6, :cond_2

    iget-object v6, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 181
    new-instance v13, Ljava/lang/StringBuilder;

    const-string v15, "source:"

    invoke-direct {v13, v15}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    move-object/from16 v22, v11

    const/4 v15, 0x0

    new-array v11, v15, [Ljava/lang/Object;

    invoke-static {v6, v13, v11}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    :cond_2
    move-object/from16 v22, v11

    .line 186
    :goto_2
    :try_start_0
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->a()I

    move-result v6

    invoke-virtual {v3, v6}, Lcom/taobao/accs/utl/h;->a(I)Ljava/lang/String;

    move-result-object v15
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_18

    .line 193
    sget-object v6, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v6}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v6

    if-eqz v6, :cond_3

    iget-object v6, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 194
    new-instance v11, Ljava/lang/StringBuilder;

    const-string v13, "dataId:"

    invoke-direct {v11, v13}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v11, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    const/4 v13, 0x0

    new-array v14, v13, [Ljava/lang/Object;

    invoke-static {v6, v11, v14}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 198
    :cond_3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 203
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->available()I

    move-result v6

    const/4 v13, 0x2

    const/4 v14, 0x1

    if-lez v6, :cond_9

    move/from16 v6, p4

    if-ne v6, v13, :cond_5

    .line 205
    invoke-direct {v7, v3}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/utl/h;)Ljava/util/Map;

    move-result-object v6

    if-eqz v6, :cond_4

    const/16 v24, 0x10

    .line 206
    invoke-static/range {v24 .. v24}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v6, v13}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_4

    const/16 v13, 0x11

    .line 207
    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v6, v13}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_4

    move-object v13, v6

    move v6, v14

    goto :goto_3

    :cond_4
    move-object v13, v6

    const/4 v6, 0x0

    goto :goto_3

    :cond_5
    const/4 v6, 0x0

    const/4 v13, 0x0

    :goto_3
    if-eqz v8, :cond_8

    if-eqz v6, :cond_6

    goto :goto_4

    :cond_6
    if-ne v8, v14, :cond_7

    .line 214
    invoke-direct {v7, v3}, Lcom/taobao/accs/data/d;->a(Ljava/io/InputStream;)[B

    move-result-object v24

    goto :goto_5

    :cond_7
    move/from16 v24, v6

    const/4 v6, 0x0

    goto :goto_6

    .line 212
    :cond_8
    :goto_4
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->c()[B

    move-result-object v24

    :goto_5
    move-object/from16 v45, v24

    move/from16 v24, v6

    move-object/from16 v6, v45

    goto :goto_6

    :cond_9
    const/4 v6, 0x0

    const/4 v13, 0x0

    const/16 v24, 0x0

    .line 217
    :goto_6
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->close()V

    const-string v3, "handleMessage"

    if-nez v6, :cond_a

    :try_start_1
    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v2, "oriData is null"

    const/4 v14, 0x0

    new-array v8, v14, [Ljava/lang/Object;

    .line 220
    invoke-static {v0, v2, v8}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_8

    .line 222
    :cond_a
    sget-object v8, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v8}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v8
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_17

    if-eqz v8, :cond_b

    .line 225
    :try_start_2
    new-instance v8, Ljava/lang/String;

    invoke-direct {v8, v6}, Ljava/lang/String;-><init>([B)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_7

    .line 227
    :catch_0
    :try_start_3
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v2, v6

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    :goto_7
    iget-object v2, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 229
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v14, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v8, 0x0

    new-array v14, v8, [Ljava/lang/Object;

    invoke-static {v2, v0, v14}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_b
    :goto_8
    const/16 v0, 0xf

    shr-long v26, v4, v0

    const-wide/16 v28, 0x1

    move-object v8, v11

    move-object v14, v12

    and-long v11, v26, v28

    long-to-int v0, v11

    .line 232
    invoke-static {v0}, Lcom/taobao/accs/data/Message$c;->a(I)I

    move-result v11

    const/16 v0, 0xd

    shr-long v26, v4, v0

    const-wide/16 v30, 0x3

    move-object v12, v8

    and-long v8, v26, v30

    long-to-int v0, v8

    .line 233
    invoke-static {v0}, Lcom/taobao/accs/data/Message$ReqType;->valueOf(I)Lcom/taobao/accs/data/Message$ReqType;

    move-result-object v8

    const/16 v0, 0xc

    shr-long v26, v4, v0

    move-object v9, v12

    move-object/from16 v30, v13

    and-long v12, v26, v28

    long-to-int v2, v12

    const/16 v0, 0xb

    shr-long v12, v4, v0

    and-long v12, v12, v28

    long-to-int v0, v12

    if-nez v0, :cond_c

    const/4 v12, 0x0

    goto :goto_9

    :cond_c
    const/4 v12, 0x1

    :goto_9
    const/4 v13, 0x6

    shr-long v26, v4, v13

    move-object/from16 v31, v14

    and-long v13, v26, v28

    long-to-int v0, v13

    const/4 v13, 0x1

    if-ne v0, v13, :cond_d

    const/4 v14, 0x1

    goto :goto_a

    :cond_d
    const/4 v14, 0x0

    .line 237
    :goto_a
    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->I:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v0}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_17

    const-string v13, "target"

    move-object/from16 v26, v9

    const-string v9, "dataId"

    if-eqz v0, :cond_e

    :try_start_4
    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    move-wide/from16 v32, v4

    const/16 v4, 0xa

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v9, v4, v5

    const/4 v5, 0x1

    aput-object v15, v4, v5

    const-string v5, "type"

    const/16 v25, 0x2

    aput-object v5, v4, v25

    .line 240
    invoke-static {v11}, Lcom/taobao/accs/data/Message$c;->b(I)Ljava/lang/String;

    move-result-object v5

    const/16 v28, 0x3

    aput-object v5, v4, v28

    const-string v5, "reqType"

    const/16 v27, 0x4

    aput-object v5, v4, v27

    .line 241
    invoke-virtual {v8}, Lcom/taobao/accs/data/Message$ReqType;->name()Ljava/lang/String;

    move-result-object v5

    const/16 v29, 0x5

    aput-object v5, v4, v29

    const-string v5, "resType"

    const/16 v29, 0x6

    aput-object v5, v4, v29

    .line 242
    invoke-static {v12}, Lcom/taobao/accs/data/Message$b;->a(I)Ljava/lang/String;

    move-result-object v5

    const/16 v29, 0x7

    aput-object v5, v4, v29

    const/16 v5, 0x8

    aput-object v13, v4, v5

    const/16 v5, 0x9

    aput-object v10, v4, v5

    .line 238
    invoke-static {v0, v3, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_b

    :cond_e
    move-wide/from16 v32, v4

    :goto_b
    const/4 v4, 0x1

    if-ne v11, v4, :cond_15

    .line 247
    sget-object v0, Lcom/taobao/accs/data/Message$ReqType;->ACK:Lcom/taobao/accs/data/Message$ReqType;

    if-eq v8, v0, :cond_f

    sget-object v0, Lcom/taobao/accs/data/Message$ReqType;->RES:Lcom/taobao/accs/data/Message$ReqType;

    if-ne v8, v0, :cond_15

    :cond_f
    iget-object v0, v7, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 248
    new-instance v4, Lcom/taobao/accs/data/Message$a;

    const/4 v5, 0x0

    invoke-direct {v4, v5, v15}, Lcom/taobao/accs/data/Message$a;-><init>(ILjava/lang/String;)V

    invoke-interface {v0, v4}, Ljava/util/concurrent/ConcurrentMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v5, v0

    check-cast v5, Lcom/taobao/accs/data/Message;

    if-eqz v5, :cond_14

    .line 250
    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v0}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v0

    if-eqz v0, :cond_10

    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v4, "handleMessage reqMessage not null"

    move/from16 v29, v12

    move/from16 v34, v14

    const/4 v12, 0x0

    new-array v14, v12, [Ljava/lang/Object;

    .line 251
    invoke-static {v0, v4, v14}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_c

    :cond_10
    move/from16 v29, v12

    move/from16 v34, v14

    .line 253
    :goto_c
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_17

    const/4 v4, 0x1

    if-ne v2, v4, :cond_11

    .line 256
    :try_start_5
    new-instance v0, Lorg/json/JSONObject;

    new-instance v4, Ljava/lang/String;

    invoke-direct {v4, v6}, Ljava/lang/String;-><init>([B)V

    invoke-direct {v0, v4}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v4, "code"

    .line 257
    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    .line 258
    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->parseHttpCode(I)Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_d

    :catchall_0
    move-exception v0

    .line 260
    :try_start_6
    sget-object v4, Lcom/taobao/accs/AccsErrorCode;->RESPONSE_PARSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v6}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v12, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v12, ", tr:"

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    .line 262
    :goto_d
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    sget-object v4, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v4

    if-eq v1, v4, :cond_11

    iget-object v1, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v4, 0x2

    new-array v12, v4, [Ljava/lang/Object;

    .line 263
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v4, 0x0

    aput-object v2, v12, v4

    const/4 v2, 0x1

    aput-object v0, v12, v2

    invoke-static {v1, v3, v12}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 266
    :cond_11
    invoke-virtual {v5}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v1

    if-eqz v1, :cond_12

    .line 267
    invoke-virtual {v5}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onRecAck()V

    .line 270
    :cond_12
    sget-object v1, Lcom/taobao/accs/data/Message$ReqType;->RES:Lcom/taobao/accs/data/Message$ReqType;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_17

    if-ne v8, v1, :cond_13

    move-object/from16 v1, p0

    move-object v2, v5

    move-object v14, v3

    move-object v3, v0

    move-wide/from16 v35, v32

    move-object v4, v8

    move-object v12, v5

    move-object v5, v6

    move-object/from16 v32, v14

    move-object/from16 v37, v18

    move-object v14, v6

    move-object/from16 v6, v30

    .line 271
    :try_start_7
    invoke-virtual/range {v1 .. v6}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/data/Message$ReqType;[BLjava/util/Map;)V

    move-object/from16 v5, v30

    goto :goto_e

    :cond_13
    move-object v12, v5

    move-object v14, v6

    move-object/from16 v37, v18

    move-object/from16 v5, v30

    move-wide/from16 v35, v32

    move-object/from16 v32, v3

    .line 273
    invoke-virtual {v7, v12, v0, v5}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Ljava/util/Map;)V

    .line 275
    :goto_e
    new-instance v0, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    iget-object v2, v12, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v3

    move-object/from16 v12, p2

    array-length v1, v12

    move-object/from16 v30, v5

    int-to-long v5, v1

    move-object v1, v0

    move-object/from16 v4, p3

    move-object/from16 v18, v13

    move-object/from16 v13, v30

    invoke-direct/range {v1 .. v6}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;-><init>(Ljava/lang/String;ZLjava/lang/String;J)V

    invoke-virtual {v7, v0}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V

    goto :goto_f

    :cond_14
    move/from16 v29, v12

    move/from16 v34, v14

    move-object/from16 v37, v18

    move-wide/from16 v35, v32

    move-object/from16 v12, p2

    move-object/from16 v32, v3

    move-object v14, v6

    move-object/from16 v18, v13

    move-object/from16 v13, v30

    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    const/4 v1, 0x0

    .line 278
    invoke-virtual {v0, v1}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v1, 0x5

    invoke-static {v15, v10, v2, v1}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v2

    const/4 v1, 0x1

    .line 277
    invoke-virtual {v0, v2, v1}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v2, "handleMessage data ack/res reqMessage is null"

    const/4 v3, 0x2

    new-array v4, v3, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v9, v4, v3

    aput-object v15, v4, v1

    .line 280
    invoke-static {v0, v2, v4}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_f

    :cond_15
    move/from16 v29, v12

    move/from16 v34, v14

    move-object/from16 v37, v18

    move-wide/from16 v35, v32

    move-object/from16 v12, p2

    move-object/from16 v32, v3

    move-object v14, v6

    move-object/from16 v18, v13

    move-object/from16 v13, v30

    :goto_f
    if-nez v11, :cond_18

    .line 285
    sget-object v0, Lcom/taobao/accs/data/Message$ReqType;->RES:Lcom/taobao/accs/data/Message$ReqType;

    if-ne v8, v0, :cond_18

    iget-object v0, v7, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 286
    new-instance v1, Lcom/taobao/accs/data/Message$a;

    const/4 v2, 0x0

    invoke-direct {v1, v2, v15}, Lcom/taobao/accs/data/Message$a;-><init>(ILjava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ConcurrentMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/accs/data/Message;

    if-eqz v0, :cond_16

    move-object/from16 v5, p3

    .line 288
    invoke-direct {v7, v0, v14, v12, v5}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;[B[BLjava/lang/String;)V

    return-void

    :cond_16
    move-object/from16 v5, p3

    const-string v0, "4|sal|st"

    move-object/from16 v6, v31

    .line 291
    invoke-virtual {v6, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_17

    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    const/4 v1, 0x0

    .line 293
    invoke-virtual {v0, v1}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v1, 0x5

    invoke-static {v15, v10, v2, v1}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v2

    const/4 v1, 0x1

    .line 292
    invoke-virtual {v0, v2, v1}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    :cond_17
    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v1, "handleMessage contorl ACK reqMessage is null"

    const/4 v2, 0x2

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object v9, v3, v2

    const/4 v2, 0x1

    aput-object v15, v3, v2

    .line 296
    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 297
    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v0}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v0

    if-eqz v0, :cond_19

    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v1, "handleMessage not handled"

    const/4 v2, 0x2

    new-array v3, v2, [Ljava/lang/Object;

    const-string v2, "body"

    const/4 v4, 0x0

    aput-object v2, v3, v4

    .line 298
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v14}, Ljava/lang/String;-><init>([B)V

    const/4 v4, 0x1

    aput-object v2, v3, v4

    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1

    goto :goto_10

    :catch_1
    move-exception v0

    goto/16 :goto_26

    :cond_18
    move-object/from16 v5, p3

    move-object/from16 v6, v31

    :cond_19
    :goto_10
    const/4 v1, 0x1

    if-ne v11, v1, :cond_2c

    .line 304
    :try_start_8
    sget-object v0, Lcom/taobao/accs/data/Message$ReqType;->DATA:Lcom/taobao/accs/data/Message$ReqType;
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_16

    if-ne v8, v0, :cond_2c

    if-nez v10, :cond_1a

    :try_start_9
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    const/4 v2, 0x0

    .line 306
    invoke-virtual {v0, v2}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_2

    move-object/from16 v11, v22

    :try_start_a
    invoke-static {v15, v11, v3, v1}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    return-void

    :catch_2
    move-exception v0

    move-object/from16 v11, v22

    goto/16 :goto_23

    :cond_1a
    move-object/from16 v11, v22

    const-string v0, "\\|"

    .line 309
    invoke-virtual {v10, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 310
    array-length v1, v0

    const/4 v2, 0x2

    if-ge v1, v2, :cond_1b

    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    const/4 v1, 0x0

    .line 311
    invoke-virtual {v0, v1}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v1, 0x1

    invoke-static {v15, v11, v2, v1}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    return-void

    .line 314
    :cond_1b
    sget-object v1, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v1}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v1

    if-eqz v1, :cond_1c

    iget-object v1, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v2, "handleMessage onPush"

    const/4 v3, 0x2

    new-array v4, v3, [Ljava/lang/Object;

    const-string v3, "isBurstData"

    const/4 v8, 0x0

    aput-object v3, v4, v8

    .line 315
    invoke-static/range {v24 .. v24}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const/4 v8, 0x1

    aput-object v3, v4, v8

    invoke-static {v1, v2, v4}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1c
    iget-object v1, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    if-eqz v1, :cond_1d

    .line 318
    invoke-virtual {v1}, Lcom/taobao/accs/ut/a/d;->a()V

    .line 320
    :cond_1d
    new-instance v1, Lcom/taobao/accs/ut/a/d;

    invoke-direct {v1}, Lcom/taobao/accs/ut/a/d;-><init>()V

    iput-object v1, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 321
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/taobao/accs/ut/a/d;->c:Ljava/lang/String;

    iget-object v1, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_15

    const/4 v2, 0x1

    .line 323
    :try_start_b
    aget-object v3, v0, v2
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_14

    :try_start_c
    invoke-static {v1, v3}, Lcom/taobao/accs/utl/UtilityImpl;->c(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_15

    if-eqz v1, :cond_2b

    .line 324
    :try_start_d
    array-length v1, v0
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_11

    const/4 v2, 0x3

    if-lt v1, v2, :cond_1e

    const/4 v1, 0x2

    :try_start_e
    aget-object v2, v0, v1
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_15

    move-object v8, v2

    goto :goto_11

    :cond_1e
    const/4 v8, 0x0

    :goto_11
    :try_start_f
    iget-object v1, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 325
    iput-object v8, v1, Lcom/taobao/accs/ut/a/d;->e:Ljava/lang/String;

    move-object/from16 v1, v26

    .line 326
    invoke-direct {v7, v1}, Lcom/taobao/accs/data/d;->c(Ljava/lang/String;)Z

    move-result v2
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_11

    if-eqz v2, :cond_1f

    :try_start_10
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    const/4 v1, 0x0

    .line 327
    invoke-virtual {v0, v1}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v1, 0x2

    invoke-static {v15, v8, v2, v1}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v2

    const/4 v12, 0x1

    invoke-virtual {v0, v2, v12}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v2, "handleMessage msg duplicate"

    new-array v14, v1, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object v9, v14, v1

    aput-object v15, v14, v12

    .line 328
    invoke-static {v0, v2, v14}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 329
    iput-boolean v12, v0, Lcom/taobao/accs/ut/a/d;->h:Z
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_15

    move-object/from16 v18, v6

    move-object/from16 v22, v11

    move-object/from16 v30, v13

    move-object/from16 v12, v21

    move/from16 v1, v29

    move/from16 v11, v34

    move-wide/from16 v13, v35

    const/4 v2, 0x1

    const/16 v23, 0x0

    goto/16 :goto_1c

    :cond_1f
    if-eqz v24, :cond_23

    .line 332
    :try_start_11
    invoke-direct {v7, v1, v13, v14}, Lcom/taobao/accs/data/d;->a(Ljava/lang/String;Ljava/util/Map;[B)[B

    move-result-object v2
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_6

    if-nez v2, :cond_20

    :try_start_12
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_5

    const/4 v14, 0x0

    .line 334
    :try_start_13
    invoke-virtual {v0, v14}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_4

    const/4 v2, 0x1

    :try_start_14
    invoke-static {v15, v8, v1, v2}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v1

    invoke-virtual {v0, v1, v2}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_3

    return-void

    :catch_3
    move-exception v0

    goto :goto_12

    :catch_4
    move-exception v0

    const/4 v2, 0x1

    goto :goto_12

    :catch_5
    move-exception v0

    const/4 v2, 0x1

    const/4 v14, 0x0

    :goto_12
    move v8, v2

    move-object v5, v11

    move-object v2, v14

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    goto/16 :goto_25

    :cond_20
    move/from16 v14, p1

    const/4 v3, 0x1

    if-ne v14, v3, :cond_22

    .line 338
    :try_start_15
    new-instance v3, Lcom/taobao/accs/utl/h;

    invoke-direct {v3, v2}, Lcom/taobao/accs/utl/h;-><init>([B)V

    .line 339
    invoke-direct {v7, v3}, Lcom/taobao/accs/data/d;->a(Ljava/io/InputStream;)[B

    move-result-object v2

    .line 340
    sget-object v4, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v4}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v4

    if-eqz v4, :cond_21

    iget-object v4, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v14, "handleMessage gzip completeOriData"
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_6

    move-object/from16 v22, v11

    const/4 v12, 0x4

    :try_start_16
    new-array v11, v12, [Ljava/lang/Object;

    const/4 v12, 0x0

    aput-object v9, v11, v12

    const/4 v12, 0x1

    aput-object v1, v11, v12

    const-string v12, "length"

    const/16 v24, 0x2

    aput-object v12, v11, v24

    .line 341
    array-length v12, v2

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    const/16 v24, 0x3

    aput-object v12, v11, v24

    invoke-static {v4, v14, v11}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_13

    :cond_21
    move-object/from16 v22, v11

    .line 343
    :goto_13
    invoke-virtual {v3}, Lcom/taobao/accs/utl/h;->close()V
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_1

    goto :goto_14

    :cond_22
    move-object/from16 v22, v11

    :goto_14
    const/16 v23, 0x0

    goto :goto_15

    :catch_6
    move-exception v0

    move-object/from16 v22, v11

    goto/16 :goto_26

    :cond_23
    move-object/from16 v22, v11

    const/16 v23, 0x0

    move-object v2, v14

    .line 349
    :goto_15
    :try_start_17
    invoke-direct {v7, v1}, Lcom/taobao/accs/data/d;->d(Ljava/lang/String;)V
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_10

    move-object/from16 v12, v21

    .line 351
    :try_start_18
    invoke-virtual {v12, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_f

    const-string v3, "handleMessage try deliverMsg"

    const-string v4, "serviceId"

    if-eqz v1, :cond_24

    :try_start_19
    iget-object v1, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v11, 0x6

    new-array v11, v11, [Ljava/lang/Object;

    const/4 v14, 0x0

    aput-object v9, v11, v14

    const/4 v14, 0x1

    aput-object v15, v11, v14

    const/16 v21, 0x2

    aput-object v18, v11, v21

    .line 352
    aget-object v18, v0, v14

    const/4 v14, 0x3

    aput-object v18, v11, v14

    const/4 v14, 0x4

    aput-object v4, v11, v14

    const/4 v14, 0x5

    aput-object v8, v11, v14

    invoke-static {v1, v3, v11}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_7

    goto :goto_17

    :catch_7
    move-exception v0

    :goto_16
    move-object v6, v12

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v5, v22

    move-object/from16 v2, v23

    goto/16 :goto_28

    .line 354
    :cond_24
    :try_start_1a
    sget-object v1, Lcom/taobao/accs/utl/ALog$Level;->I:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v1}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v1
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_f

    if-eqz v1, :cond_25

    :try_start_1b
    iget-object v1, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v11, 0x6

    new-array v11, v11, [Ljava/lang/Object;

    const/4 v14, 0x0

    aput-object v9, v11, v14

    const/4 v14, 0x1

    aput-object v15, v11, v14

    const/16 v21, 0x2

    aput-object v18, v11, v21

    .line 355
    aget-object v18, v0, v14

    const/4 v14, 0x3

    aput-object v18, v11, v14

    const/4 v14, 0x4

    aput-object v4, v11, v14
    :try_end_1b
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_8

    const/4 v14, 0x5

    :try_start_1c
    aput-object v8, v11, v14

    invoke-static {v1, v3, v11}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1c
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_7

    goto :goto_18

    :catch_8
    move-exception v0

    const/4 v14, 0x5

    goto :goto_16

    :cond_25
    :goto_17
    const/4 v14, 0x5

    .line 358
    :goto_18
    :try_start_1d
    new-instance v1, Landroid/content/Intent;

    const-string v3, "com.taobao.accs.intent.action.RECEIVE"

    invoke-direct {v1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    :try_end_1d
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_1d} :catch_f

    const/4 v3, 0x1

    .line 359
    :try_start_1e
    aget-object v11, v0, v3
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1e .. :try_end_1e} :catch_e

    :try_start_1f
    invoke-virtual {v1, v11}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "command"

    const/16 v11, 0x65

    .line 360
    invoke-virtual {v1, v3, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 361
    array-length v3, v0
    :try_end_1f
    .catch Ljava/lang/Exception; {:try_start_1f .. :try_end_1f} :catch_f

    const/4 v11, 0x3

    if-lt v3, v11, :cond_26

    const/4 v3, 0x2

    .line 362
    :try_start_20
    aget-object v11, v0, v3

    invoke-virtual {v1, v4, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_20} :catch_7

    .line 365
    :cond_26
    :try_start_21
    array-length v3, v0
    :try_end_21
    .catch Ljava/lang/Exception; {:try_start_21 .. :try_end_21} :catch_f

    const/4 v4, 0x4

    if-lt v3, v4, :cond_27

    const/4 v3, 0x3

    .line 366
    :try_start_22
    aget-object v0, v0, v3

    const-string v3, "userInfo"

    .line 367
    invoke-virtual {v1, v3, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    :try_end_22
    .catch Ljava/lang/Exception; {:try_start_22 .. :try_end_22} :catch_7

    goto :goto_19

    :cond_27
    move-object/from16 v0, v22

    :goto_19
    :try_start_23
    const-string v3, "data"

    .line 369
    invoke-virtual {v1, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[B)Landroid/content/Intent;

    .line 370
    invoke-virtual {v1, v9, v15}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "packageName"

    iget-object v4, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    .line 372
    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "host"

    .line 374
    invoke-virtual {v1, v3, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "conn_type"

    iget v4, v7, Lcom/taobao/accs/data/d;->b:I

    .line 375
    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "bizAck"

    move/from16 v11, v34

    .line 376
    invoke-virtual {v1, v3, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v3, "appKey"

    iget-object v4, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 377
    invoke-virtual {v4}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "configTag"

    iget-object v4, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 378
    iget-object v4, v4, Lcom/taobao/accs/net/b;->m:Ljava/lang/String;

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 380
    new-instance v3, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    invoke-direct {v3}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;-><init>()V

    const/4 v4, 0x4

    .line 381
    invoke-virtual {v3, v4}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setMsgType(I)V

    .line 382
    invoke-virtual {v3}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onReceiveData()V

    const-string v4, "monitor"

    .line 383
    invoke-virtual {v1, v4, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 385
    invoke-direct {v7, v13, v1}, Lcom/taobao/accs/data/d;->a(Ljava/util/Map;Landroid/content/Intent;)V
    :try_end_23
    .catch Ljava/lang/Exception; {:try_start_23 .. :try_end_23} :catch_f

    if-eqz v11, :cond_28

    move-wide/from16 v3, v35

    long-to-int v14, v3

    int-to-short v14, v14

    .line 388
    :try_start_24
    invoke-direct {v7, v1, v6, v10, v14}, Lcom/taobao/accs/data/d;->a(Landroid/content/Intent;Ljava/lang/String;Ljava/lang/String;S)V
    :try_end_24
    .catch Ljava/lang/Exception; {:try_start_24 .. :try_end_24} :catch_7

    goto :goto_1a

    :cond_28
    move-wide/from16 v3, v35

    :goto_1a
    :try_start_25
    const-string v14, "ACCS_TEST"

    move-wide/from16 v35, v3

    const-string v3, "start to MsgDistribute.distribMessage"

    .line 390
    invoke-static {v14, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    iget-object v4, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 391
    invoke-static {v3, v4, v1}, Lcom/taobao/accs/data/g;->a(Landroid/content/Context;Lcom/taobao/accs/net/b;Landroid/content/Intent;)V

    .line 394
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v38

    const v39, 0x101d1

    const-string v40, "MsgToBussPush"

    const-string v41, "commandId=101"

    new-instance v1, Ljava/lang/StringBuilder;

    move-object/from16 v3, v37

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " dataId="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v42

    const/16 v1, 0xde

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v43

    invoke-virtual/range {v38 .. v43}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    const-string v1, "to_buss"

    .line 395
    new-instance v3, Ljava/lang/StringBuilder;

    move-object/from16 v4, v20

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-wide/16 v4, 0x0

    invoke-static {v12, v1, v3, v4, v5}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    iget-object v1, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 396
    iput-object v15, v1, Lcom/taobao/accs/ut/a/d;->b:Ljava/lang/String;

    iget-object v1, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 397
    iput-object v0, v1, Lcom/taobao/accs/ut/a/d;->i:Ljava/lang/String;

    iget-object v0, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 398
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    if-nez v2, :cond_29

    const/4 v2, 0x0

    goto :goto_1b

    :cond_29
    array-length v2, v2

    :goto_1b
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_25 .. :try_end_25} :catch_f

    move-object/from16 v14, v22

    :try_start_26
    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/accs/ut/a/d;->f:Ljava/lang/String;

    iget-object v0, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    iget-object v1, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    .line 399
    invoke-static {v1}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/accs/ut/a/d;->a:Ljava/lang/String;

    iget-object v0, v7, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    .line 400
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/accs/ut/a/d;->d:Ljava/lang/String;

    .line 401
    new-instance v0, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v3

    move-object/from16 v1, p2

    array-length v1, v1
    :try_end_26
    .catch Ljava/lang/Exception; {:try_start_26 .. :try_end_26} :catch_d

    int-to-long v1, v1

    move-wide/from16 v20, v1

    move-object v1, v0

    move-object v2, v8

    move-wide/from16 v4, v35

    move-object/from16 v30, v13

    move-object/from16 v22, v14

    move-wide v13, v4

    move-object/from16 v4, p3

    move-object/from16 v18, v6

    move-wide/from16 v5, v20

    :try_start_27
    invoke-direct/range {v1 .. v6}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;-><init>(Ljava/lang/String;ZLjava/lang/String;J)V

    invoke-virtual {v7, v0}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V
    :try_end_27
    .catch Ljava/lang/Exception; {:try_start_27 .. :try_end_27} :catch_f

    move/from16 v1, v29

    const/4 v2, 0x1

    :goto_1c
    if-ne v1, v2, :cond_2c

    .line 404
    :try_start_28
    invoke-virtual {v12, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_28 .. :try_end_28} :catch_c

    const-string v1, "handleMessage try sendAck dataId"

    if-eqz v0, :cond_2a

    :try_start_29
    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v9, v3, v4

    aput-object v15, v3, v2

    .line 405
    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_29
    .catch Ljava/lang/Exception; {:try_start_29 .. :try_end_29} :catch_7

    const/4 v3, 0x0

    const/4 v4, 0x1

    goto :goto_1d

    :cond_2a
    :try_start_2a
    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;
    :try_end_2a
    .catch Ljava/lang/Exception; {:try_start_2a .. :try_end_2a} :catch_f

    const/4 v3, 0x0

    :try_start_2b
    aput-object v9, v2, v3
    :try_end_2b
    .catch Ljava/lang/Exception; {:try_start_2b .. :try_end_2b} :catch_b

    const/4 v4, 0x1

    :try_start_2c
    aput-object v15, v2, v4

    .line 407
    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_1d
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;
    :try_end_2c
    .catch Ljava/lang/Exception; {:try_start_2c .. :try_end_2c} :catch_a

    const/4 v1, 0x0

    long-to-int v2, v13

    int-to-short v13, v2

    move-object v2, v8

    move-object v8, v0

    move-object v9, v10

    move-object/from16 v10, v18

    move/from16 v16, v11

    move-object/from16 v5, v22

    move-object v11, v15

    move-object v6, v12

    move v12, v1

    move-object/from16 v14, v19

    move-object/from16 v1, v30

    move-object v4, v14

    move-object/from16 v3, v32

    move-object/from16 v14, p3

    move-object/from16 v19, v4

    move-object v4, v15

    move-object/from16 v44, v17

    const/4 v3, 0x0

    move-object v15, v1

    .line 409
    :try_start_2d
    invoke-static/range {v8 .. v15}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZSLjava/lang/String;Ljava/util/Map;)Lcom/taobao/accs/data/Message;

    move-result-object v0

    iget-object v1, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;
    :try_end_2d
    .catch Ljava/lang/Exception; {:try_start_2d .. :try_end_2d} :catch_9

    const/4 v8, 0x1

    .line 410
    :try_start_2e
    invoke-virtual {v1, v0, v8}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    .line 411
    iget-object v0, v0, Lcom/taobao/accs/data/Message;->q:Ljava/lang/String;

    invoke-direct {v7, v0, v2}, Lcom/taobao/accs/data/d;->a(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz v16, :cond_2c

    const-string v0, "ack"

    const-wide/16 v1, 0x0

    .line 413
    invoke-static {v6, v0, v5, v1, v2}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    goto/16 :goto_2a

    :catch_9
    move-exception v0

    goto :goto_21

    :catch_a
    move-exception v0

    move v8, v4

    move-object v6, v12

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v5, v22

    goto/16 :goto_22

    :catch_b
    move-exception v0

    move-object v6, v12

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v5, v22

    goto :goto_21

    :catch_c
    move-exception v0

    move v8, v2

    goto :goto_1e

    :catch_d
    move-exception v0

    move-object v6, v12

    move-object v5, v14

    move-object v4, v15

    move-object/from16 v44, v17

    goto :goto_20

    :catch_e
    move-exception v0

    move v8, v3

    :goto_1e
    move-object v6, v12

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v5, v22

    const/4 v3, 0x0

    goto :goto_22

    :catch_f
    move-exception v0

    move-object v6, v12

    move-object v4, v15

    move-object/from16 v44, v17

    goto :goto_1f

    :catch_10
    move-exception v0

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    :goto_1f
    move-object/from16 v5, v22

    goto :goto_20

    :catch_11
    move-exception v0

    move-object v5, v11

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    :goto_20
    const/4 v3, 0x0

    :goto_21
    const/4 v8, 0x1

    goto :goto_22

    :cond_2b
    move-object v5, v11

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    const/4 v3, 0x0

    const/4 v8, 0x1

    iget-object v1, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v2, "handleMessage not exist, unbind it"

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Object;

    const-string v10, "package"

    aput-object v10, v9, v3

    .line 417
    aget-object v10, v0, v8

    aput-object v10, v9, v8

    invoke-static {v1, v2, v9}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;
    :try_end_2e
    .catch Ljava/lang/Exception; {:try_start_2e .. :try_end_2e} :catch_13

    const/4 v2, 0x0

    .line 418
    :try_start_2f
    invoke-virtual {v1, v2}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x4

    invoke-static {v4, v5, v9, v10}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v9

    invoke-virtual {v1, v9, v8}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    iget-object v1, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 419
    aget-object v0, v0, v8

    invoke-static {v1, v0}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Ljava/lang/String;)Lcom/taobao/accs/data/Message;

    move-result-object v0

    invoke-virtual {v1, v0, v8}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V
    :try_end_2f
    .catch Ljava/lang/Exception; {:try_start_2f .. :try_end_2f} :catch_12

    goto/16 :goto_2a

    :catch_12
    move-exception v0

    goto :goto_29

    :catch_13
    move-exception v0

    :goto_22
    const/4 v2, 0x0

    goto :goto_29

    :catch_14
    move-exception v0

    move v8, v2

    move-object v5, v11

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    goto :goto_24

    :catch_15
    move-exception v0

    :goto_23
    move-object v5, v11

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    goto :goto_27

    :catch_16
    move-exception v0

    move v8, v1

    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    move-object/from16 v5, v22

    :goto_24
    const/4 v2, 0x0

    :goto_25
    const/4 v3, 0x0

    goto :goto_29

    :catch_17
    move-exception v0

    move-object/from16 v32, v3

    :goto_26
    move-object v4, v15

    move-object/from16 v44, v17

    move-object/from16 v6, v21

    move-object/from16 v5, v22

    :goto_27
    const/4 v2, 0x0

    :goto_28
    const/4 v3, 0x0

    const/4 v8, 0x1

    :goto_29
    iget-object v1, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array v3, v3, [Ljava/lang/Object;

    move-object/from16 v9, v32

    .line 423
    invoke-static {v1, v9, v0, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    iget-object v1, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 424
    invoke-virtual {v1, v2}, Lcom/taobao/accs/net/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x5

    invoke-static {v4, v5, v2, v3}, Lcom/taobao/accs/data/Message;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lcom/taobao/accs/data/Message;

    move-result-object v2

    invoke-virtual {v1, v2, v8}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    .line 425
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, v7, Lcom/taobao/accs/data/d;->b:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object/from16 v1, v19

    move-object/from16 v2, v44

    invoke-static {v6, v1, v5, v2, v0}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2c
    :goto_2a
    return-void

    :catch_18
    move-exception v0

    move-object v4, v3

    move-object/from16 v2, v17

    move-object/from16 v1, v19

    move-object/from16 v6, v21

    move-object/from16 v5, v22

    const/4 v3, 0x0

    iget-object v8, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 188
    new-instance v9, Ljava/lang/StringBuilder;

    const-string v10, "dataId read error "

    invoke-direct {v9, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v8, v9, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 189
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->close()V

    .line 190
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, v7, Lcom/taobao/accs/data/d;->b:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "data id read error"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v6, v1, v5, v2, v0}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private a(Landroid/content/Intent;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    if-eqz p1, :cond_2

    .line 965
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "source"

    .line 966
    invoke-virtual {p1, v0, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 968
    :cond_0
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-nez p2, :cond_1

    const-string p2, "target"

    .line 969
    invoke-virtual {p1, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_1
    const-string p2, "flags"

    .line 972
    invoke-virtual {p1, p2, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    :cond_2
    return-void
.end method

.method private a(Lcom/taobao/accs/data/Message;[B[BLjava/lang/String;)V
    .locals 17

    move-object/from16 v7, p0

    move-object/from16 v8, p1

    .line 473
    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    const/4 v2, 0x0

    .line 475
    :try_start_0
    new-instance v3, Lorg/json/JSONObject;

    new-instance v0, Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    move-object/from16 v5, p2

    :try_start_1
    invoke-direct {v0, v5}, Ljava/lang/String;-><init>([B)V

    invoke-direct {v3, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 476
    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v0}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const-string v4, "json"

    const-string v6, "handleControlMessage parse"

    const/4 v9, 0x2

    const/4 v10, 0x1

    if-eqz v0, :cond_0

    :try_start_2
    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array v11, v9, [Ljava/lang/Object;

    aput-object v4, v11, v2

    .line 477
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v12

    aput-object v12, v11, v10

    invoke-static {v0, v6, v11}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 480
    :cond_0
    iget-object v0, v8, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v11, 0x64

    if-ne v0, v11, :cond_1

    .line 481
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    :goto_0
    move-object v1, v0

    goto :goto_1

    :cond_1
    const-string v0, "code"

    .line 483
    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    .line 484
    invoke-static {v0}, Lcom/taobao/accs/AccsErrorCode;->parseHttpCode(I)Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    goto :goto_0

    .line 486
    :goto_1
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v12, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v12

    if-ne v0, v12, :cond_6

    .line 487
    iget-object v0, v8, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-eq v0, v10, :cond_4

    if-eq v0, v9, :cond_3

    if-eq v0, v11, :cond_2

    goto/16 :goto_4

    :cond_2
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 520
    instance-of v0, v0, Lcom/taobao/accs/net/j;

    if-eqz v0, :cond_7

    iget-object v0, v8, Lcom/taobao/accs/data/Message;->n:Ljava/lang/String;

    const-string v11, "4|sal|st"

    invoke-virtual {v0, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 521
    check-cast v0, Lcom/taobao/accs/net/j;

    .line 522
    invoke-virtual {v0, v3}, Lcom/taobao/accs/net/j;->a(Lorg/json/JSONObject;)V

    goto/16 :goto_4

    :cond_3
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 517
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v0

    iget-object v11, v8, Lcom/taobao/accs/data/Message;->s:Ljava/lang/String;

    invoke-virtual {v0, v11}, Lcom/taobao/accs/client/c;->b(Ljava/lang/String;)V

    goto/16 :goto_4

    .line 489
    :cond_4
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v0

    iget-object v11, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    iget-object v11, v11, Lcom/taobao/accs/net/b;->m:Ljava/lang/String;

    const-string v12, "bfc"

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v13

    invoke-virtual {v0, v11, v12, v13}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    const-string v0, "EMAS_ACCS_SDK"

    iget-object v11, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    .line 490
    invoke-static {v0, v11}, Lcom/taobao/accs/utl/UtilityImpl;->saveUtdid(Ljava/lang/String;Landroid/content/Context;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :try_start_3
    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 493
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v0

    iget-object v11, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    invoke-virtual {v11}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v0, v11}, Lcom/taobao/accs/client/c;->a(Ljava/lang/String;)V

    const-string v0, "data"

    .line 494
    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v11, "accsToken"

    const/4 v12, 0x0

    .line 495
    invoke-static {v0, v11, v12}, Lcom/taobao/accs/utl/JsonUtility;->getString(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    iput-object v11, v7, Lcom/taobao/accs/data/d;->e:Ljava/lang/String;

    if-eqz v0, :cond_7

    const-string v11, "packageNames"

    .line 498
    invoke-virtual {v0, v11}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_7

    move v11, v2

    .line 500
    :goto_2
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v12

    if-ge v11, v12, :cond_7

    .line 501
    invoke-virtual {v0, v11}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v12

    iget-object v13, v7, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    .line 502
    invoke-static {v13, v12}, Lcom/taobao/accs/utl/UtilityImpl;->c(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_5

    iget-object v12, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 503
    invoke-virtual {v12}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v12

    iget-object v13, v8, Lcom/taobao/accs/data/Message;->s:Ljava/lang/String;

    invoke-virtual {v12, v13}, Lcom/taobao/accs/client/c;->a(Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    iget-object v13, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v14, "unbind app"

    new-array v15, v9, [Ljava/lang/Object;

    const-string v16, "pkg"

    aput-object v16, v15, v2

    aput-object v12, v15, v10

    .line 505
    invoke-static {v13, v14, v15}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v13, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 506
    invoke-static {v13, v12}, Lcom/taobao/accs/data/Message;->a(Lcom/taobao/accs/net/b;Ljava/lang/String;)Lcom/taobao/accs/data/Message;

    move-result-object v12

    invoke-virtual {v13, v12, v10}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :goto_3
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    :catchall_0
    move-exception v0

    :try_start_4
    iget-object v11, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v12, "no token/invalid app"

    .line 512
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v11, v12, v0}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_4

    .line 529
    :cond_6
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v11, Lcom/taobao/accs/AccsErrorCode;->APP_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v11}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v11

    if-ne v0, v11, :cond_7

    iget-object v0, v7, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 530
    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v0

    iget-object v11, v8, Lcom/taobao/accs/data/Message;->s:Ljava/lang/String;

    invoke-virtual {v0, v11}, Lcom/taobao/accs/client/c;->b(Ljava/lang/String;)V

    .line 533
    :cond_7
    :goto_4
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v11, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v11}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v11

    if-eq v0, v11, :cond_8

    iget-object v0, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array v9, v9, [Ljava/lang/Object;

    aput-object v4, v9, v2

    .line 534
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v9, v10

    invoke-static {v0, v6, v9}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_6

    :catchall_1
    move-exception v0

    goto :goto_5

    :catchall_2
    move-exception v0

    move-object/from16 v5, p2

    :goto_5
    iget-object v3, v7, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "handleControlMessage"

    .line 537
    invoke-static {v3, v4, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 538
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget v3, v7, Lcom/taobao/accs/data/d;->b:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "accs"

    const-string v3, "send_fail"

    const-string v6, ""

    invoke-static {v2, v3, v4, v6, v0}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_8
    :goto_6
    move-object v3, v1

    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v5, p2

    .line 540
    invoke-virtual/range {v1 .. v6}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/data/Message$ReqType;[BLjava/util/Map;)V

    .line 541
    new-instance v0, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    iget-object v9, v8, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v10

    move-object/from16 v1, p3

    array-length v1, v1

    int-to-long v12, v1

    move-object v8, v0

    move-object/from16 v11, p4

    invoke-direct/range {v8 .. v13}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;-><init>(Ljava/lang/String;ZLjava/lang/String;J)V

    invoke-virtual {v7, v0}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    .line 1031
    new-instance v0, Lcom/taobao/accs/ut/a/e;

    invoke-direct {v0}, Lcom/taobao/accs/ut/a/e;-><init>()V

    iget-object v1, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    .line 1032
    invoke-static {v1}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/accs/ut/a/e;->a:Ljava/lang/String;

    .line 1033
    iput-object p1, v0, Lcom/taobao/accs/ut/a/e;->c:Ljava/lang/String;

    .line 1034
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-direct {p1, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/taobao/accs/ut/a/e;->d:Ljava/lang/String;

    .line 1035
    iput-object v1, v0, Lcom/taobao/accs/ut/a/e;->f:Ljava/lang/String;

    .line 1036
    iput-object p2, v0, Lcom/taobao/accs/ut/a/e;->e:Ljava/lang/String;

    .line 1037
    iput-object v1, v0, Lcom/taobao/accs/ut/a/e;->b:Ljava/lang/String;

    .line 1038
    invoke-virtual {v0}, Lcom/taobao/accs/ut/a/e;->a()V

    return-void
.end method

.method private a(Ljava/util/Map;Landroid/content/Intent;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;",
            "Landroid/content/Intent;",
            ")V"
        }
    .end annotation

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    const-string v0, "ext_header"

    .line 959
    check-cast p1, Ljava/util/HashMap;

    invoke-virtual {p2, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    :cond_0
    return-void
.end method

.method private a(Ljava/io/InputStream;)[B
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 433
    :cond_0
    new-instance v1, Ljava/util/zip/GZIPInputStream;

    invoke-direct {v1, p1}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V

    .line 434
    new-instance p1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v2, 0x2000

    const/4 v3, 0x0

    :try_start_0
    new-array v2, v2, [B

    .line 440
    :goto_0
    invoke-virtual {v1, v2}, Ljava/util/zip/GZIPInputStream;->read([B)I

    move-result v4

    if-lez v4, :cond_1

    .line 441
    invoke-virtual {p1, v2, v3, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 444
    :cond_1
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 452
    :try_start_1
    invoke-virtual {v1}, Ljava/util/zip/GZIPInputStream;->close()V

    .line 456
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-object v0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v2

    :try_start_2
    iget-object v4, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 447
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "uncompress data error "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v4, v5, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v3, "accs"

    const-string v4, "send_fail"

    const-string v5, ""

    const-string v6, "1"

    .line 448
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    iget v8, p0, Lcom/taobao/accs/data/d;->b:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " uncompress data error "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v4, v5, v6, v2}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 452
    :try_start_3
    invoke-virtual {v1}, Ljava/util/zip/GZIPInputStream;->close()V

    .line 456
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-object v0

    .line 452
    :goto_1
    :try_start_4
    invoke-virtual {v1}, Ljava/util/zip/GZIPInputStream;->close()V

    .line 456
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    .line 460
    :catch_3
    throw v0
.end method

.method private a(Ljava/lang/String;Ljava/util/Map;[B)[B
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;[B)[B"
        }
    .end annotation

    const-string v0, "putBurstMessage"

    const/4 v1, 0x0

    if-eqz p3, :cond_5

    .line 867
    :try_start_0
    array-length v2, p3

    if-eqz v2, :cond_5

    const/16 v2, 0x11

    .line 870
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {p2, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    const/16 v3, 0x10

    .line 871
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {p2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_4

    const/4 v5, 0x2

    if-ltz v2, :cond_3

    if-ge v2, v3, :cond_3

    const/16 v6, 0x12

    .line 878
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {p2, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    const/16 v7, 0xf

    const-wide/16 v8, 0x0

    .line 882
    :try_start_1
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-interface {p2, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    .line 883
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_0

    .line 884
    invoke-static {p2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p2

    :try_start_2
    iget-object v7, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array v10, v1, [Ljava/lang/Object;

    .line 887
    invoke-static {v7, v0, p2, v10}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    iget-object p2, p0, Lcom/taobao/accs/data/d;->n:Ljava/util/Map;

    .line 889
    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/taobao/accs/data/a;

    if-nez p2, :cond_2

    .line 891
    sget-object p2, Lcom/taobao/accs/utl/ALog$Level;->I:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {p2}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Object;

    const-string v10, "dataId"

    aput-object v10, v7, v1

    aput-object p1, v7, v4

    const-string v4, "burstLength"

    aput-object v4, v7, v5

    .line 892
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v5, 0x3

    aput-object v4, v7, v5

    invoke-static {p2, v0, v7}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 894
    :cond_1
    new-instance p2, Lcom/taobao/accs/data/a;

    invoke-direct {p2, p1, v3, v6}, Lcom/taobao/accs/data/a;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 895
    invoke-virtual {p2, v8, v9}, Lcom/taobao/accs/data/a;->a(J)V

    iget-object v4, p0, Lcom/taobao/accs/data/d;->n:Ljava/util/Map;

    .line 896
    invoke-interface {v4, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 898
    :cond_2
    invoke-virtual {p2, v2, v3, p3}, Lcom/taobao/accs/data/a;->a(II[B)[B

    move-result-object p1

    return-object p1

    .line 876
    :cond_3
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "burstNums:%s burstIndex:%s"

    new-array p3, v5, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, p3, v1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, p3, v4

    invoke-static {p2, p3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 873
    :cond_4
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "burstNums <= 1"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 868
    :cond_5
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "burstLength == 0"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :catchall_1
    move-exception p1

    iget-object p2, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array p3, v1, [Ljava/lang/Object;

    .line 900
    invoke-static {p2, v0, p1, p3}, Lcom/taobao/accs/utl/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method private b(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V
    .locals 5

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    .line 995
    invoke-static {v0}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 996
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 998
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    sget-object v3, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v3

    const/4 v4, 0x1

    if-eq v2, v3, :cond_1

    const/4 v2, 0x0

    goto :goto_0

    :cond_1
    move v2, v4

    .line 1001
    :goto_0
    iget-object v3, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    if-eq v3, v4, :cond_3

    const/4 v4, 0x3

    if-eq v3, v4, :cond_2

    goto :goto_1

    .line 1011
    :cond_2
    new-instance v3, Lcom/taobao/accs/ut/a/b;

    invoke-direct {v3}, Lcom/taobao/accs/ut/a/b;-><init>()V

    .line 1012
    iput-object v0, v3, Lcom/taobao/accs/ut/a/b;->a:Ljava/lang/String;

    .line 1013
    iput-object v1, v3, Lcom/taobao/accs/ut/a/b;->b:Ljava/lang/String;

    .line 1014
    iput-boolean v2, v3, Lcom/taobao/accs/ut/a/b;->c:Z

    .line 1015
    iget-object p1, p1, Lcom/taobao/accs/data/Message;->G:Ljava/lang/String;

    iput-object p1, v3, Lcom/taobao/accs/ut/a/b;->e:Ljava/lang/String;

    .line 1016
    invoke-virtual {v3, p2}, Lcom/taobao/accs/ut/a/b;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    .line 1017
    invoke-virtual {v3}, Lcom/taobao/accs/ut/a/b;->a()V

    goto :goto_1

    .line 1003
    :cond_3
    new-instance p1, Lcom/taobao/accs/ut/a/a;

    invoke-direct {p1}, Lcom/taobao/accs/ut/a/a;-><init>()V

    .line 1004
    iput-object v0, p1, Lcom/taobao/accs/ut/a/a;->a:Ljava/lang/String;

    .line 1005
    iput-object v1, p1, Lcom/taobao/accs/ut/a/a;->b:Ljava/lang/String;

    .line 1006
    iput-boolean v2, p1, Lcom/taobao/accs/ut/a/a;->c:Z

    .line 1007
    invoke-virtual {p1, p2}, Lcom/taobao/accs/ut/a/a;->a(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    .line 1008
    invoke-virtual {p1}, Lcom/taobao/accs/ut/a/a;->a()V

    :goto_1
    return-void
.end method

.method private b(Lcom/alibaba/sdk/android/error/ErrorCode;)Z
    .locals 2

    .line 699
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 700
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->REQ_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 701
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SPDY_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 702
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->INAPP_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 703
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SPDY_PING_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 704
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->NO_NETWORK:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 705
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->NETWORKSDK_SPDY_CLOSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 706
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_TIMEOUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 707
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_CONNECT_FAIL:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 708
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_NO_STRATEGY:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 709
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result p1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-ne p1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method

.method private c(Lcom/taobao/accs/data/Message;)Landroid/content/Intent;
    .locals 3

    .line 946
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.taobao.accs.intent.action.RECEIVE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 947
    iget-object v1, p1, Lcom/taobao/accs/data/Message;->s:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "command"

    .line 948
    iget-object v2, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    const-string v1, "serviceId"

    .line 949
    iget-object v2, p1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "userInfo"

    .line 950
    iget-object v2, p1, Lcom/taobao/accs/data/Message;->G:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 951
    iget-object v1, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v1, :cond_0

    iget-object v1, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/16 v2, 0x64

    if-ne v1, v2, :cond_0

    const-string v1, "dataId"

    .line 952
    iget-object p1, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_0
    return-object v0
.end method

.method private c(Ljava/lang/String;)Z
    .locals 1

    .line 856
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/data/d;->m:Ljava/util/LinkedHashMap;

    .line 859
    invoke-virtual {v0, p1}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method private d(Ljava/lang/String;)V
    .locals 1

    .line 907
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/accs/data/d;->m:Ljava/util/LinkedHashMap;

    invoke-virtual {v0, p1}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/data/d;->m:Ljava/util/LinkedHashMap;

    .line 910
    invoke-virtual {v0, p1, p1}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 911
    invoke-direct {p0}, Lcom/taobao/accs/data/d;->j()V

    :cond_1
    :goto_0
    return-void
.end method

.method private i()V
    .locals 5

    const-string v0, "message"

    .line 916
    :try_start_0
    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    const-string v3, "emas_accs"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v2, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 917
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v1, "message file not exist"

    new-array v2, v4, [Ljava/lang/Object;

    .line 918
    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 921
    :cond_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/FileReader;

    invoke-direct {v2, v1}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 923
    :goto_0
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v2, p0, Lcom/taobao/accs/data/d;->m:Ljava/util/LinkedHashMap;

    .line 924
    invoke-virtual {v2, v1, v1}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 926
    :cond_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 928
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_1
    return-void
.end method

.method private j()V
    .locals 6

    const-string v0, "message"

    .line 934
    :try_start_0
    new-instance v1, Ljava/io/FileWriter;

    new-instance v2, Ljava/io/File;

    iget-object v3, p0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    const-string v4, "emas_accs"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->i()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v3, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    const-string v0, ""

    .line 935
    invoke-virtual {v1, v0}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/data/d;->m:Ljava/util/LinkedHashMap;

    .line 936
    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 937
    invoke-virtual {v1, v2}, Ljava/io/FileWriter;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    move-result-object v2

    const-string v3, "\r\n"

    invoke-virtual {v2, v3}, Ljava/io/Writer;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    goto :goto_0

    .line 939
    :cond_0
    invoke-virtual {v1}, Ljava/io/FileWriter;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 941
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    :goto_1
    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lcom/taobao/accs/data/Message;
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 844
    new-instance v1, Lcom/taobao/accs/data/Message$a;

    const/4 v2, 0x0

    invoke-direct {v1, v2, p1}, Lcom/taobao/accs/data/Message$a;-><init>(ILjava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/accs/data/Message;

    return-object p1
.end method

.method public a()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v1, "onSendPing"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 717
    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-class v0, Lcom/taobao/accs/data/d;

    .line 718
    monitor-enter v0

    const/4 v1, 0x1

    :try_start_0
    iput-boolean v1, p0, Lcom/taobao/accs/data/d;->g:Z

    .line 720
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public a(Lcom/alibaba/sdk/android/error/ErrorCode;)V
    .locals 5

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/data/d;->g:Z

    iget-object v1, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 770
    invoke-interface {v1}, Ljava/util/concurrent/ConcurrentMap;->keySet()Ljava/util/Set;

    move-result-object v1

    new-array v2, v0, [Lcom/taobao/accs/data/Message$a;

    invoke-interface {v1, v2}, Ljava/util/Set;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Lcom/taobao/accs/data/Message$a;

    .line 771
    array-length v2, v1

    if-lez v2, :cond_1

    iget-object v2, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v3, "onNetworkFail"

    new-array v4, v0, [Ljava/lang/Object;

    .line 772
    invoke-static {v2, v3, v4}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 773
    array-length v2, v1

    :goto_0
    if-ge v0, v2, :cond_1

    aget-object v3, v1, v0

    iget-object v4, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 774
    invoke-interface {v4, v3}, Ljava/util/concurrent/ConcurrentMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/taobao/accs/data/Message;

    if-eqz v3, :cond_0

    .line 776
    invoke-virtual {p0, v3, p1}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method public a(Lcom/taobao/accs/data/Message;)V
    .locals 8

    const-string v0, "ACCS_TEST"

    const-string v1, "MessageHandler onSend"

    .line 749
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/taobao/accs/data/d;->j:Lcom/taobao/accs/data/Message;

    if-eqz v0, :cond_0

    .line 750
    iget-object v0, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/data/d;->j:Lcom/taobao/accs/data/Message;

    iget-object v0, v0, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    iget-object v1, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    .line 753
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/data/d;->j:Lcom/taobao/accs/data/Message;

    iget-object v0, v0, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    iget-object v1, p1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    .line 754
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 755
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v1

    const v2, 0x101d1

    const-string v3, "SEND_REPEAT"

    iget-object v4, p1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    iget-object v5, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getId()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    invoke-virtual/range {v1 .. v6}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 757
    :cond_0
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->a()I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_2

    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->a()I

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    iget-boolean v0, p1, Lcom/taobao/accs/data/Message;->c:Z

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 760
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->d()Lcom/taobao/accs/data/Message$a;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Ljava/util/concurrent/ConcurrentMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    :goto_0
    return-void
.end method

.method public a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V
    .locals 6

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    .line 580
    invoke-virtual/range {v0 .. v5}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/data/Message$ReqType;[BLjava/util/Map;)V

    return-void
.end method

.method public a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/data/Message$ReqType;[BLjava/util/Map;)V
    .locals 22
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/taobao/accs/data/Message;",
            "Lcom/alibaba/sdk/android/error/ErrorCode;",
            "Lcom/taobao/accs/data/Message$ReqType;",
            "[B",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    .line 597
    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    const/4 v3, 0x0

    if-eqz v2, :cond_16

    invoke-virtual/range {p1 .. p1}, Lcom/taobao/accs/data/Message;->a()I

    move-result v2

    if-ltz v2, :cond_16

    invoke-virtual/range {p1 .. p1}, Lcom/taobao/accs/data/Message;->a()I

    move-result v2

    const/4 v4, 0x2

    if-ne v2, v4, :cond_0

    goto/16 :goto_6

    .line 601
    :cond_0
    iget-object v2, v1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    if-eqz v2, :cond_1

    iget-object v2, v0, Lcom/taobao/accs/data/d;->a:Ljava/util/concurrent/ConcurrentMap;

    .line 602
    iget-object v5, v1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-interface {v2, v5}, Ljava/util/concurrent/ConcurrentMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget-object v2, v0, Lcom/taobao/accs/data/d;->d:Lcom/taobao/accs/flowcontrol/FlowControl;

    .line 605
    iget-object v5, v1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    move-object/from16 v6, p5

    invoke-virtual {v2, v6, v5}, Lcom/taobao/accs/flowcontrol/FlowControl;->a(Ljava/util/Map;Ljava/lang/String;)I

    move-result v2

    const/4 v5, 0x3

    const/4 v7, 0x0

    if-eqz v2, :cond_4

    if-ne v2, v4, :cond_2

    .line 608
    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->SERVIER_HIGH_LIMIT:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_0

    :cond_2
    if-ne v2, v5, :cond_3

    .line 610
    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->SERVIER_HIGH_LIMIT_BRUSH:Lcom/alibaba/sdk/android/error/ErrorCode;

    goto :goto_0

    .line 612
    :cond_3
    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->SERVIER_LOW_LIMIT:Lcom/alibaba/sdk/android/error/ErrorCode;

    :goto_0
    move-object v4, v7

    move-object v6, v4

    move-object v8, v6

    goto :goto_1

    :cond_4
    move-object/from16 v2, p2

    move-object/from16 v4, p3

    move-object v8, v6

    move-object/from16 v6, p4

    .line 618
    :goto_1
    sget-object v9, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v9}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v9

    const-string v10, "command"

    const-string v11, "onResult"

    if-eqz v9, :cond_5

    iget-object v9, v0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 619
    iget-object v12, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    const-string v13, "erorcode"

    filled-new-array {v10, v12, v13, v2}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v9, v11, v12}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 621
    :cond_5
    iget-object v9, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    const/16 v12, 0x66

    if-ne v9, v12, :cond_6

    return-void

    .line 624
    :cond_6
    iget-object v9, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    const/4 v12, 0x1

    if-ne v9, v12, :cond_7

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v9

    sget-object v13, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v13

    if-ne v9, v13, :cond_8

    .line 625
    :cond_7
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v9

    sget-object v13, Lcom/taobao/accs/AccsErrorCode;->APP_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v13

    if-ne v9, v13, :cond_9

    :cond_8
    iget-object v9, v0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 626
    invoke-virtual {v9}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v9

    iget-object v13, v1, Lcom/taobao/accs/data/Message;->s:Ljava/lang/String;

    invoke-virtual {v9, v13}, Lcom/taobao/accs/client/c;->b(Ljava/lang/String;)V

    .line 628
    :cond_9
    iget-boolean v9, v1, Lcom/taobao/accs/data/Message;->e:Z

    const-wide/16 v13, 0x0

    const-string v15, "accs"

    if-nez v9, :cond_e

    .line 629
    invoke-direct {v0, v2}, Lcom/taobao/accs/data/d;->b(Lcom/alibaba/sdk/android/error/ErrorCode;)Z

    move-result v9

    if-eqz v9, :cond_a

    iget-object v9, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 630
    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9

    const/16 v10, 0x64

    if-eq v9, v10, :cond_a

    iget v9, v1, Lcom/taobao/accs/data/Message;->R:I

    sget v10, Lcom/taobao/accs/data/Message;->a:I

    if-gt v9, v10, :cond_a

    .line 632
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v1, Lcom/taobao/accs/data/Message;->T:J

    .line 633
    iget v4, v1, Lcom/taobao/accs/data/Message;->R:I

    add-int/2addr v4, v12

    iput v4, v1, Lcom/taobao/accs/data/Message;->R:I

    iget-object v4, v0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 634
    iget v5, v1, Lcom/taobao/accs/data/Message;->R:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const-string v6, "retryTimes"

    filled-new-array {v6, v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v11, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v4, v0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 635
    invoke-virtual {v4, v1, v12}, Lcom/taobao/accs/net/b;->b(Lcom/taobao/accs/data/Message;Z)V

    goto/16 :goto_2

    .line 637
    :cond_a
    invoke-direct/range {p0 .. p1}, Lcom/taobao/accs/data/d;->c(Lcom/taobao/accs/data/Message;)Landroid/content/Intent;

    move-result-object v9

    const-string v10, "errorObj"

    .line 638
    invoke-virtual {v9, v10, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 639
    iget-short v10, v1, Lcom/taobao/accs/data/Message;->k:S

    shr-int/lit8 v10, v10, 0xd

    and-int/2addr v5, v10

    invoke-static {v5}, Lcom/taobao/accs/data/Message$ReqType;->valueOf(I)Lcom/taobao/accs/data/Message$ReqType;

    move-result-object v5

    .line 641
    sget-object v10, Lcom/taobao/accs/data/Message$ReqType;->RES:Lcom/taobao/accs/data/Message$ReqType;

    if-eq v4, v10, :cond_b

    sget-object v4, Lcom/taobao/accs/data/Message$ReqType;->REQ:Lcom/taobao/accs/data/Message$ReqType;

    if-ne v5, v4, :cond_c

    :cond_b
    const-string v4, "send_type"

    const-string v5, "res"

    .line 642
    invoke-virtual {v9, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 644
    :cond_c
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v4

    sget-object v5, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v5}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v5

    if-ne v4, v5, :cond_d

    const-string v4, "data"

    .line 645
    invoke-virtual {v9, v4, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[B)Landroid/content/Intent;

    :cond_d
    iget-object v4, v0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 647
    iget-object v4, v4, Lcom/taobao/accs/net/b;->b:Ljava/lang/String;

    const-string v5, "appKey"

    invoke-virtual {v9, v5, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v4, v0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 648
    iget-object v4, v4, Lcom/taobao/accs/net/b;->m:Ljava/lang/String;

    const-string v5, "configTag"

    invoke-virtual {v9, v5, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 650
    invoke-direct {v0, v8, v9}, Lcom/taobao/accs/data/d;->a(Ljava/util/Map;Landroid/content/Intent;)V

    iget-object v4, v0, Lcom/taobao/accs/data/d;->h:Landroid/content/Context;

    iget-object v5, v0, Lcom/taobao/accs/data/d;->k:Lcom/taobao/accs/net/b;

    .line 651
    invoke-static {v4, v5, v9}, Lcom/taobao/accs/data/g;->a(Landroid/content/Context;Lcom/taobao/accs/net/b;Landroid/content/Intent;)V

    .line 655
    iget-object v4, v1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_f

    .line 656
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v16

    const v17, 0x101d1

    const-string v18, "MsgToBuss0"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "commandId="

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v5, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "serviceId="

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v6, v1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " errorCode="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " dataId="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, v1, Lcom/taobao/accs/data/Message;->q:Ljava/lang/String;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    const/16 v4, 0xde

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v21

    invoke-virtual/range {v16 .. v21}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 657
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v6, "1commandId="

    invoke-direct {v4, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v6, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "to_buss"

    invoke-static {v15, v5, v4, v13, v14}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    goto :goto_2

    :cond_e
    iget-object v4, v0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 661
    iget-object v5, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    filled-new-array {v10, v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "onResult message is cancel"

    invoke-static {v4, v6, v5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 665
    :cond_f
    :goto_2
    invoke-virtual/range {p1 .. p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v4

    if-eqz v4, :cond_15

    .line 667
    invoke-virtual {v4}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onToBizDate()V

    .line 668
    iget-object v5, v1, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    if-nez v5, :cond_10

    goto :goto_3

    :cond_10
    iget-object v5, v1, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    invoke-virtual {v5}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v7

    .line 669
    :goto_3
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v5

    sget-object v6, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v6

    const-string v8, "Request_Success_Rate"

    const-string v9, "resend"

    if-ne v5, v6, :cond_12

    .line 670
    invoke-virtual {v4, v12}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setRet(Z)V

    .line 671
    iget v3, v1, Lcom/taobao/accs/data/Message;->R:I

    if-lez v3, :cond_11

    const-string v3, "succ"

    .line 672
    invoke-static {v15, v9, v3, v13, v14}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    .line 673
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "succ_"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v4, v1, Lcom/taobao/accs/data/Message;->R:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v15, v9, v3, v13, v14}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    goto :goto_5

    .line 675
    :cond_11
    invoke-static {v15, v8, v7}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmSuccess(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_5

    .line 678
    :cond_12
    iget v5, v1, Lcom/taobao/accs/data/Message;->R:I

    if-lez v5, :cond_13

    .line 679
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "fail\uff3f"

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v15, v9, v5, v13, v14}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    const-string v5, "fail"

    .line 680
    invoke-static {v15, v9, v5, v13, v14}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitCount(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    goto :goto_4

    .line 682
    :cond_13
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v5

    sget-object v6, Lcom/taobao/accs/AccsErrorCode;->NO_NETWORK:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v6

    if-eq v5, v6, :cond_14

    .line 684
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v5

    invoke-static {v5}, Lcom/taobao/accs/utl/UtilityImpl;->a(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    iget v9, v0, Lcom/taobao/accs/data/d;->b:I

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v9, v1, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v9, v1, Lcom/taobao/accs/data/Message;->S:I

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 683
    invoke-static {v15, v8, v7, v5, v6}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 687
    :cond_14
    :goto_4
    invoke-virtual {v4, v3}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setRet(Z)V

    .line 688
    invoke-virtual {v4, v2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setFailReason(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    .line 691
    :goto_5
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v4

    invoke-interface {v3, v4}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 694
    :cond_15
    invoke-direct {v0, v1, v2}, Lcom/taobao/accs/data/d;->b(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    return-void

    :cond_16
    :goto_6
    iget-object v1, v0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v2, "onError, skip ping/ack"

    new-array v3, v3, [Ljava/lang/Object;

    .line 598
    invoke-static {v1, v2, v3}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Ljava/util/Map;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/taobao/accs/data/Message;",
            "Lcom/alibaba/sdk/android/error/ErrorCode;",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p3

    .line 584
    invoke-virtual/range {v0 .. v5}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/data/Message$ReqType;[BLjava/util/Map;)V

    return-void
.end method

.method public a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V
    .locals 3

    .line 1052
    :try_start_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v1, Lcom/taobao/accs/data/e;

    invoke-direct {v1, p0, p1}, Lcom/taobao/accs/data/e;-><init>(Lcom/taobao/accs/data/d;Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "addTrafficsInfo"

    .line 1061
    invoke-static {v0, v2, p1, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method public a([B)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 115
    invoke-virtual {p0, p1, v0}, Lcom/taobao/accs/data/d;->a([BLjava/lang/String;)V

    return-void
.end method

.method public a([BLjava/lang/String;)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const-string v0, ""

    const-string v1, "totalLen:"

    const-string v2, "compress:"

    const-string v3, "version:"

    .line 126
    sget-object v4, Lcom/taobao/accs/utl/ALog$Level;->I:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v4}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v4

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v5, "host"

    .line 127
    filled-new-array {v5, p2}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "onMessage"

    invoke-static {v4, v6, v5}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 129
    :cond_0
    new-instance v4, Lcom/taobao/accs/utl/h;

    invoke-direct {v4, p1}, Lcom/taobao/accs/utl/h;-><init>([B)V

    const/4 p1, 0x0

    .line 131
    :try_start_0
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->a()I

    move-result v5

    and-int/lit16 v6, v5, 0xf0

    shr-int/lit8 v6, v6, 0x4

    .line 133
    sget-object v7, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v7}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v7

    if-eqz v7, :cond_1

    iget-object v7, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 134
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v8, p1, [Ljava/lang/Object;

    invoke-static {v7, v3, v8}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    and-int/lit8 v3, v5, 0xf

    .line 137
    sget-object v5, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v5}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v5

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 138
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v7, p1, [Ljava/lang/Object;

    invoke-static {v5, v2, v7}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 140
    :cond_2
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->a()I

    .line 141
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->b()I

    move-result v2

    .line 142
    sget-object v5, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v5}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v5

    if-eqz v5, :cond_3

    iget-object v5, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 143
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v7, p1, [Ljava/lang/Object;

    invoke-static {v5, v1, v7}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_3
    move v1, p1

    :goto_0
    if-ge v1, v2, :cond_6

    .line 147
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->b()I

    move-result v5

    add-int/lit8 v1, v1, 0x2

    if-lez v5, :cond_5

    .line 150
    new-array v7, v5, [B

    .line 151
    invoke-virtual {v4, v7}, Lcom/taobao/accs/utl/h;->read([B)I

    .line 152
    sget-object v8, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v8}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v8

    if-eqz v8, :cond_4

    iget-object v8, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    .line 153
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "buf len:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    new-array v10, p1, [Ljava/lang/Object;

    invoke-static {v8, v9, v10}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    add-int/2addr v1, v5

    .line 156
    invoke-direct {p0, v3, v7, p2, v6}, Lcom/taobao/accs/data/d;->a(I[BLjava/lang/String;I)V

    goto :goto_0

    .line 158
    :cond_5
    new-instance p2, Ljava/io/IOException;

    const-string v1, "data format error"

    invoke-direct {p2, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 165
    :cond_6
    :goto_1
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->close()V

    goto :goto_2

    :catchall_0
    move-exception p2

    :try_start_1
    const-string v1, "accs"

    const-string v2, "send_fail"

    const-string v3, "1"

    .line 162
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget v6, p0, Lcom/taobao/accs/data/d;->b:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p2}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v2, v0, v3, v5}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    new-array p1, p1, [Ljava/lang/Object;

    .line 163
    invoke-static {v1, v0, p2, p1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :goto_2
    return-void

    :catchall_1
    move-exception p1

    .line 165
    invoke-virtual {v4}, Lcom/taobao/accs/utl/h;->close()V

    .line 166
    throw p1
.end method

.method public b(Ljava/lang/String;)Lcom/taobao/accs/data/Message;
    .locals 3

    .line 849
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 850
    new-instance v1, Lcom/taobao/accs/data/Message$a;

    const/4 v2, 0x0

    invoke-direct {v1, v2, p1}, Lcom/taobao/accs/data/Message$a;-><init>(ILjava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ConcurrentMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/accs/data/Message;

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return-object p1
.end method

.method public b()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v1, "onRcvPing"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    .line 728
    invoke-static {v0, v1, v3}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-class v0, Lcom/taobao/accs/data/d;

    .line 729
    monitor-enter v0

    :try_start_0
    iput-boolean v2, p0, Lcom/taobao/accs/data/d;->g:Z

    .line 731
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public b(Lcom/taobao/accs/data/Message;)V
    .locals 5

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 788
    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    if-lez v0, :cond_5

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 789
    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/accs/data/Message$a;

    iget-object v2, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 790
    invoke-interface {v2, v1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/accs/data/Message;

    if-eqz v1, :cond_4

    .line 791
    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v2, :cond_4

    .line 793
    invoke-virtual {v1}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->f()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 794
    iget-object v2, p1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v3, 0x1

    packed-switch v2, :pswitch_data_0

    goto :goto_1

    .line 811
    :pswitch_0
    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v4, 0x5

    if-eq v2, v4, :cond_1

    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 812
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v4, 0x6

    if-ne v2, v4, :cond_4

    .line 813
    :cond_1
    iput-boolean v3, v1, Lcom/taobao/accs/data/Message;->e:Z

    goto :goto_1

    .line 804
    :pswitch_1
    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v4, 0x3

    if-eq v2, v4, :cond_2

    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 805
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v4, 0x4

    if-ne v2, v4, :cond_4

    .line 806
    :cond_2
    iput-boolean v3, v1, Lcom/taobao/accs/data/Message;->e:Z

    goto :goto_1

    .line 797
    :pswitch_2
    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-eq v2, v3, :cond_3

    iget-object v2, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 798
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v4, 0x2

    if-ne v2, v4, :cond_4

    .line 799
    :cond_3
    iput-boolean v3, v1, Lcom/taobao/accs/data/Message;->e:Z

    :cond_4
    :goto_1
    if-eqz v1, :cond_0

    .line 818
    iget-boolean v2, v1, Lcom/taobao/accs/data/Message;->e:Z

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const-string v3, "command"

    .line 819
    iget-object v1, v1, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    filled-new-array {v3, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v3, "cancelControlMessage"

    invoke-static {v2, v3, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_0

    :cond_5
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_2
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public c()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/accs/data/d;->g:Z

    return v0
.end method

.method public d()I
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 832
    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->size()I

    move-result v0

    return v0
.end method

.method public e()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection<",
            "Lcom/taobao/accs/data/Message;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 836
    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->values()Ljava/util/Collection;

    move-result-object v0

    return-object v0
.end method

.method public f()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Lcom/taobao/accs/data/Message$a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/data/d;->f:Ljava/util/concurrent/ConcurrentMap;

    .line 840
    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->keySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method public g()Lcom/taobao/accs/ut/a/d;
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/data/d;->i:Lcom/taobao/accs/ut/a/d;

    return-object v0
.end method

.method public h()V
    .locals 4

    .line 1043
    :try_start_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/accs/data/d;->o:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/taobao/accs/data/d;->l:Ljava/lang/String;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "restoreTraffics"

    .line 1045
    invoke-static {v1, v3, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
