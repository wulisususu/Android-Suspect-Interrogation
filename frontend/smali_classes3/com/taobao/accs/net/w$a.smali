.class Lcom/taobao/accs/net/w$a;
.super Ljava/lang/Thread;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/net/w;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field public a:I

.field b:J

.field final synthetic c:Lcom/taobao/accs/net/w;

.field private final d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/taobao/accs/net/w;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 648
    invoke-direct {p0, p2}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    .line 641
    invoke-virtual {p0}, Lcom/taobao/accs/net/w$a;->getName()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const/4 p1, 0x0

    iput p1, p0, Lcom/taobao/accs/net/w$a;->a:I

    return-void
.end method

.method private a(Z)V
    .locals 9

    iget-object v0, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 652
    invoke-static {v0}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result v0

    const-wide/16 v1, 0x1388

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eq v0, v4, :cond_5

    iget-object v0, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 653
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    const-string v6, "force"

    filled-new-array {v6, v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v7, "tryConnect"

    invoke-static {v0, v7, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p1, :cond_0

    iput v3, p0, Lcom/taobao/accs/net/w$a;->a:I

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    .line 657
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iget v5, p0, Lcom/taobao/accs/net/w$a;->a:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const-string v8, "failTimes"

    filled-new-array {v6, p1, v8, v5}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, v7, p1}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 658
    invoke-static {p1}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result p1

    if-eq p1, v4, :cond_1

    iget p1, p0, Lcom/taobao/accs/net/w$a;->a:I

    const/4 v0, 0x4

    if-lt p1, v0, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 659
    invoke-static {p1, v4}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;Z)Z

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v1, "maxTimes"

    .line 660
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "tryConnect fail"

    invoke-static {p1, v1, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_1

    :cond_1
    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 661
    invoke-static {p1}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result p1

    if-eq p1, v4, :cond_6

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 662
    iget p1, p1, Lcom/taobao/accs/net/w;->c:I

    if-ne p1, v4, :cond_2

    iget p1, p0, Lcom/taobao/accs/net/w$a;->a:I

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v0, "tryConnect in app, no sleep"

    new-array v1, v3, [Ljava/lang/Object;

    .line 663
    invoke-static {p1, v0, v1}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v0, "tryConnect, need sleep"

    new-array v5, v3, [Ljava/lang/Object;

    .line 665
    invoke-static {p1, v0, v5}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 667
    :try_start_0
    invoke-static {v1, v2}, Lcom/taobao/accs/net/w$a;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 669
    invoke-virtual {p1}, Ljava/lang/InterruptedException;->printStackTrace()V

    :goto_0
    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    const-string v0, ""

    .line 672
    invoke-static {p1, v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;Ljava/lang/String;)Ljava/lang/String;

    iget p1, p0, Lcom/taobao/accs/net/w$a;->a:I

    const/4 v0, 0x3

    if-ne p1, v0, :cond_3

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 675
    invoke-static {p1}, Lcom/taobao/accs/net/w;->e(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/net/g;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/taobao/accs/net/g;->b(Ljava/lang/String;)V

    :cond_3
    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    const/4 v0, 0x0

    .line 677
    invoke-static {p1, v0}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 678
    invoke-static {p1}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object p1

    iget v0, p0, Lcom/taobao/accs/net/w$a;->a:I

    invoke-virtual {p1, v0}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setRetryTimes(I)V

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 679
    invoke-static {p1}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result p1

    if-eq p1, v4, :cond_4

    iget p1, p0, Lcom/taobao/accs/net/w$a;->a:I

    add-int/2addr p1, v4

    iput p1, p0, Lcom/taobao/accs/net/w$a;->a:I

    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v0, "try connect fail, ready for reconnect"

    new-array v1, v3, [Ljava/lang/Object;

    .line 681
    invoke-static {p1, v0, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 682
    invoke-direct {p0, v3}, Lcom/taobao/accs/net/w$a;->a(Z)V

    goto :goto_1

    .line 684
    :cond_4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/accs/net/w$a;->b:J

    goto :goto_1

    :cond_5
    iget-object p1, p0, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 687
    invoke-static {p1}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result p1

    if-ne p1, v4, :cond_6

    .line 688
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/taobao/accs/net/w$a;->b:J

    sub-long/2addr v4, v6

    cmp-long p1, v4, v1

    if-lez p1, :cond_6

    iput v3, p0, Lcom/taobao/accs/net/w$a;->a:I

    :cond_6
    :goto_1
    return-void
.end method


# virtual methods
.method public run()V
    .locals 20

    move-object/from16 v1, p0

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "NetworkThread run"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    .line 696
    invoke-static {v0, v2, v4}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iput v3, v1, Lcom/taobao/accs/net/w$a;->a:I

    const/4 v0, 0x0

    :goto_0
    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 699
    invoke-static {v2}, Lcom/taobao/accs/net/w;->f(Lcom/taobao/accs/net/w;)Z

    move-result v2

    if-eqz v2, :cond_20

    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v4, "ready to get message"

    new-array v5, v3, [Ljava/lang/Object;

    .line 700
    invoke-static {v2, v4, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 701
    invoke-static {v2}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v2

    monitor-enter v2

    :try_start_0
    iget-object v4, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 702
    invoke-static {v4}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/LinkedList;->size()I

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_e

    if-nez v4, :cond_0

    :try_start_1
    iget-object v4, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v5, "no message, wait"

    new-array v6, v3, [Ljava/lang/Object;

    .line 704
    invoke-static {v4, v5, v6}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v4, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 705
    invoke-static {v4}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_e

    goto :goto_1

    :catch_0
    move-exception v0

    .line 707
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 708
    monitor-exit v2

    goto/16 :goto_e

    :cond_0
    :goto_1
    iget-object v4, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v5, "try get message"

    new-array v6, v3, [Ljava/lang/Object;

    .line 711
    invoke-static {v4, v5, v6}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v4, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 712
    invoke-static {v4}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/LinkedList;->size()I

    move-result v4

    if-eqz v4, :cond_1

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 713
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/LinkedList;->getFirst()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/accs/data/Message;

    .line 714
    invoke-virtual {v0}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 715
    invoke-virtual {v0}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v4

    invoke-virtual {v4}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onTakeFromQueue()V

    :cond_1
    move-object v4, v0

    .line 718
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_e

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 719
    invoke-static {v0}, Lcom/taobao/accs/net/w;->f(Lcom/taobao/accs/net/w;)Z

    move-result v0

    if-nez v0, :cond_2

    goto/16 :goto_e

    :cond_2
    if-eqz v4, :cond_1f

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "sendMessage not null"

    new-array v5, v3, [Ljava/lang/Object;

    .line 723
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/16 v2, 0xc9

    const/16 v5, 0x64

    const/4 v6, 0x1

    .line 726
    :try_start_3
    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->a()I

    move-result v0

    iget-object v7, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v8, "sendMessage"

    const/4 v9, 0x4

    new-array v10, v9, [Ljava/lang/Object;

    const-string v11, "type"

    aput-object v11, v10, v3

    .line 727
    invoke-static {v0}, Lcom/taobao/accs/data/Message$c;->b(I)Ljava/lang/String;

    move-result-object v11

    aput-object v11, v10, v6

    const-string v11, "status"

    const/4 v12, 0x2

    aput-object v11, v10, v12

    iget-object v11, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-static {v11}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result v11

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    const/4 v13, 0x3

    aput-object v11, v10, v13

    invoke-static {v7, v8, v10}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-ne v0, v12, :cond_6

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 729
    iget v0, v0, Lcom/taobao/accs/net/w;->c:I

    if-ne v0, v6, :cond_3

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v7, "sendMessage INAPP ping, skip"

    new-array v8, v3, [Ljava/lang/Object;

    .line 730
    invoke-static {v0, v7, v8}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_6

    :try_start_4
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "send succ, remove it"

    new-array v5, v3, [Ljava/lang/Object;

    .line 814
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 815
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v2

    monitor-enter v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :try_start_5
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 816
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/util/LinkedList;->remove(Ljava/lang/Object;)Z

    .line 817
    monitor-exit v2

    goto/16 :goto_d

    :catchall_0
    move-exception v0

    monitor-exit v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :try_start_6
    throw v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    :catchall_1
    move-exception v0

    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v5, " run finally error"

    new-array v6, v3, [Ljava/lang/Object;

    .line 820
    invoke-static {v2, v5, v0, v6}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_d

    .line 733
    :cond_3
    :try_start_7
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-static {v0}, Lcom/taobao/accs/net/w;->g(Lcom/taobao/accs/net/w;)J

    move-result-wide v10

    sub-long/2addr v7, v10

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    iget-object v0, v0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/net/f;->b()I

    move-result v0

    sub-int/2addr v0, v6

    mul-int/lit16 v0, v0, 0x3e8

    int-to-long v10, v0

    cmp-long v0, v7, v10

    if-gez v0, :cond_5

    iget-boolean v0, v4, Lcom/taobao/accs/data/Message;->d:Z

    if-eqz v0, :cond_4

    goto :goto_2

    .line 750
    :cond_4
    invoke-direct {v1, v3}, Lcom/taobao/accs/net/w$a;->a(Z)V

    goto/16 :goto_6

    :cond_5
    :goto_2
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v7, "sendMessage"

    new-array v8, v9, [Ljava/lang/Object;

    const-string v9, "force"

    aput-object v9, v8, v3

    .line 734
    iget-boolean v9, v4, Lcom/taobao/accs/data/Message;->d:Z

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    aput-object v9, v8, v6

    const-string v9, "last ping"

    aput-object v9, v8, v12

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    iget-object v11, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-static {v11}, Lcom/taobao/accs/net/w;->g(Lcom/taobao/accs/net/w;)J

    move-result-wide v11

    sub-long/2addr v9, v11

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    aput-object v9, v8, v13

    invoke-static {v0, v7, v8}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 735
    invoke-direct {v1, v6}, Lcom/taobao/accs/net/w$a;->a(Z)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 736
    invoke-static {v0}, Lcom/taobao/accs/net/w;->h(Lcom/taobao/accs/net/w;)Lorg/android/spdy/SpdySession;

    move-result-object v0

    if-eqz v0, :cond_d

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-static {v0}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result v0

    if-ne v0, v6, :cond_d

    .line 737
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-static {v0}, Lcom/taobao/accs/net/w;->g(Lcom/taobao/accs/net/w;)J

    move-result-wide v9

    sub-long/2addr v7, v9

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    iget-object v0, v0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/accs/net/f;->a(Landroid/content/Context;)Lcom/taobao/accs/net/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/net/f;->b()I

    move-result v0

    sub-int/2addr v0, v6

    mul-int/lit16 v0, v0, 0x3e8

    int-to-long v9, v0

    cmp-long v0, v7, v9

    if-ltz v0, :cond_f

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v7, "sendMessage onSendPing"

    new-array v8, v3, [Ljava/lang/Object;

    .line 738
    invoke-static {v0, v7, v8}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 739
    iget-object v0, v0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v0}, Lcom/taobao/accs/data/d;->a()V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 740
    invoke-static {v0}, Lcom/taobao/accs/net/w;->h(Lcom/taobao/accs/net/w;)Lorg/android/spdy/SpdySession;

    move-result-object v0

    invoke-virtual {v0}, Lorg/android/spdy/SpdySession;->submitPing()I

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 741
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->onSendPing()V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 742
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    invoke-static {v0, v7, v8}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;J)J

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 743
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v7

    invoke-static {v0, v7, v8}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;J)J

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 744
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->f()V

    goto/16 :goto_6

    :cond_6
    if-ne v0, v6, :cond_e

    .line 753
    invoke-direct {v1, v6}, Lcom/taobao/accs/net/w$a;->a(Z)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 754
    invoke-static {v0}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result v0

    if-ne v0, v6, :cond_d

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-static {v0}, Lcom/taobao/accs/net/w;->h(Lcom/taobao/accs/net/w;)Lorg/android/spdy/SpdySession;

    move-result-object v0

    if-eqz v0, :cond_d

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 755
    iget-object v0, v0, Lcom/taobao/accs/net/w;->d:Landroid/content/Context;

    iget-object v7, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    iget v7, v7, Lcom/taobao/accs/net/w;->c:I

    invoke-virtual {v4, v0, v7}, Lcom/taobao/accs/data/Message;->a(Landroid/content/Context;I)[B

    move-result-object v0

    .line 756
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    invoke-virtual {v4, v7, v8}, Lcom/taobao/accs/data/Message;->a(J)V

    .line 757
    array-length v7, v0

    const/16 v8, 0x4000

    if-le v7, v8, :cond_7

    iget-object v7, v4, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    const/16 v8, 0x66

    if-eq v7, v8, :cond_7

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 758
    iget-object v0, v0, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v7, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_TOO_LARGE:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0, v4, v7}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto/16 :goto_6

    .line 761
    :cond_7
    iget-boolean v7, v4, Lcom/taobao/accs/data/Message;->c:Z

    if-eqz v7, :cond_8

    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->d()Lcom/taobao/accs/data/Message$a;

    move-result-object v7

    invoke-virtual {v7}, Lcom/taobao/accs/data/Message$a;->a()I

    move-result v7

    neg-int v7, v7

    goto :goto_3

    :cond_8
    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->d()Lcom/taobao/accs/data/Message$a;

    move-result-object v7

    invoke-virtual {v7}, Lcom/taobao/accs/data/Message$a;->a()I

    move-result v7

    :goto_3
    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 762
    invoke-static {v8}, Lcom/taobao/accs/net/w;->h(Lcom/taobao/accs/net/w;)Lorg/android/spdy/SpdySession;

    move-result-object v14

    const/16 v16, 0xc8

    const/16 v17, 0x0

    if-nez v0, :cond_9

    move/from16 v18, v3

    goto :goto_4

    :cond_9
    array-length v8, v0

    move/from16 v18, v8

    :goto_4
    move v15, v7

    move-object/from16 v19, v0

    invoke-virtual/range {v14 .. v19}, Lorg/android/spdy/SpdySession;->sendCustomControlFrame(IIII[B)I

    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v10, "send data"

    const/4 v11, 0x6

    new-array v11, v11, [Ljava/lang/Object;

    const-string v14, "length"

    aput-object v14, v11, v3

    if-nez v0, :cond_a

    move v14, v3

    goto :goto_5

    .line 763
    :cond_a
    array-length v14, v0

    :goto_5
    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v11, v6

    const-string v14, "dataId"

    aput-object v14, v11, v12

    .line 764
    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v14

    aput-object v14, v11, v13

    const-string v13, "utdid"

    aput-object v13, v11, v9

    iget-object v9, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    iget-object v9, v9, Lcom/taobao/accs/net/w;->j:Ljava/lang/String;

    const/4 v13, 0x5

    aput-object v9, v11, v13

    .line 763
    invoke-static {v8, v10, v11}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 765
    iget-object v8, v8, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v8, v4}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;)V

    .line 767
    iget-boolean v8, v4, Lcom/taobao/accs/data/Message;->c:Z

    if-eqz v8, :cond_b

    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v9, "sendCFrame end ack"

    new-array v10, v12, [Ljava/lang/Object;

    const-string v11, "dataId"

    aput-object v11, v10, v3

    .line 768
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v10, v6

    invoke-static {v8, v9, v10}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 769
    iget-object v8, v8, Lcom/taobao/accs/net/w;->l:Ljava/util/LinkedHashMap;

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v8, v7, v4}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 772
    :cond_b
    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v7

    if-eqz v7, :cond_c

    .line 773
    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object v7

    invoke-virtual {v7}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onSendData()V

    :cond_c
    iget-object v7, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 775
    invoke-virtual {v4}, Lcom/taobao/accs/data/Message;->b()Ljava/lang/String;

    move-result-object v8

    iget-object v9, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    iget-object v9, v9, Lcom/taobao/accs/net/w;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v9}, Lcom/taobao/accs/AccsClientConfig;->isQuickReconnect()Z

    move-result v9

    iget v10, v4, Lcom/taobao/accs/data/Message;->S:I

    int-to-long v10, v10

    invoke-virtual {v7, v8, v9, v10, v11}, Lcom/taobao/accs/net/w;->a(Ljava/lang/String;ZJ)V

    iget-object v7, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 777
    iget-object v7, v7, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    new-instance v14, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    iget-object v9, v4, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v10

    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    invoke-virtual {v8}, Lcom/taobao/accs/net/w;->r()Ljava/lang/String;

    move-result-object v11

    array-length v0, v0

    int-to-long v12, v0

    move-object v8, v14

    invoke-direct/range {v8 .. v13}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;-><init>(Ljava/lang/String;ZLjava/lang/String;J)V

    invoke-virtual {v7, v14}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V

    goto :goto_6

    :cond_d
    move v7, v3

    goto :goto_7

    .line 784
    :cond_e
    invoke-direct {v1, v3}, Lcom/taobao/accs/net/w$a;->a(Z)V

    iget-object v7, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v8, "skip msg"

    new-array v9, v12, [Ljava/lang/Object;

    const-string v10, "type"

    aput-object v10, v9, v3

    .line 786
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v9, v6

    invoke-static {v7, v8, v9}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_6

    :cond_f
    :goto_6
    move v7, v6

    :goto_7
    :try_start_8
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 788
    invoke-static {v0}, Lcom/taobao/accs/net/w;->i(Lcom/taobao/accs/net/w;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_5

    if-nez v7, :cond_14

    :try_start_9
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 797
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 798
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    if-eqz v0, :cond_10

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 799
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    const-string v7, "send fail"

    invoke-virtual {v0, v7}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    :cond_10
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 801
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v7

    monitor-enter v7
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    :try_start_a
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 802
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/LinkedList;->size()I

    move-result v0

    sub-int/2addr v0, v6

    :goto_8
    if-ltz v0, :cond_13

    iget-object v6, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 803
    invoke-static {v6}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/util/LinkedList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/taobao/accs/data/Message;

    if-eqz v6, :cond_12

    .line 804
    iget-object v8, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v8, :cond_12

    iget-object v8, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 805
    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-eq v8, v5, :cond_11

    iget-object v8, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-ne v8, v2, :cond_12

    :cond_11
    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 806
    iget-object v8, v8, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v9, Lcom/taobao/accs/AccsErrorCode;->SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v8, v6, v9}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    iget-object v6, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 807
    invoke-static {v6}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    :cond_12
    add-int/lit8 v0, v0, -0x1

    goto :goto_8

    :cond_13
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "network disconnected, wait"

    new-array v5, v3, [Ljava/lang/Object;

    .line 810
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 811
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V

    .line 812
    monitor-exit v7

    goto/16 :goto_d

    :catchall_2
    move-exception v0

    monitor-exit v7
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    :try_start_b
    throw v0

    :cond_14
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "send succ, remove it"

    new-array v5, v3, [Ljava/lang/Object;

    .line 814
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 815
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v2

    monitor-enter v2
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    :try_start_c
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 816
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/util/LinkedList;->remove(Ljava/lang/Object;)Z

    .line 817
    monitor-exit v2

    goto/16 :goto_d

    :catchall_3
    move-exception v0

    monitor-exit v2
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    :try_start_d
    throw v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_4

    :catchall_4
    move-exception v0

    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v5, " run finally error"

    new-array v6, v3, [Ljava/lang/Object;

    .line 820
    invoke-static {v2, v5, v0, v6}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_d

    :catchall_5
    move-exception v0

    goto :goto_9

    :catchall_6
    move-exception v0

    move v7, v6

    :goto_9
    :try_start_e
    const-string v8, "accs"

    const-string v9, "send_fail"

    .line 791
    iget-object v10, v4, Lcom/taobao/accs/data/Message;->H:Ljava/lang/String;

    const-string v11, "1"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v13, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    iget v13, v13, Lcom/taobao/accs/net/w;->c:I

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v8, v9, v10, v11, v12}, Lcom/taobao/accs/utl/AppMonitorAdapter;->commitAlarmFail(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 792
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v9, "service connection run"

    new-array v10, v3, [Ljava/lang/Object;

    .line 793
    invoke-static {v8, v9, v0, v10}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_a

    if-nez v7, :cond_19

    :try_start_f
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 797
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 798
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    if-eqz v0, :cond_15

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 799
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    const-string v7, "send fail"

    invoke-virtual {v0, v7}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    :cond_15
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 801
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v7

    monitor-enter v7
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_9

    :try_start_10
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 802
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/LinkedList;->size()I

    move-result v0

    sub-int/2addr v0, v6

    :goto_a
    if-ltz v0, :cond_18

    iget-object v6, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 803
    invoke-static {v6}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/util/LinkedList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/taobao/accs/data/Message;

    if-eqz v6, :cond_17

    .line 804
    iget-object v8, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v8, :cond_17

    iget-object v8, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 805
    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-eq v8, v5, :cond_16

    iget-object v8, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-ne v8, v2, :cond_17

    :cond_16
    iget-object v8, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 806
    iget-object v8, v8, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v9, Lcom/taobao/accs/AccsErrorCode;->SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v8, v6, v9}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    iget-object v6, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 807
    invoke-static {v6}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    :cond_17
    add-int/lit8 v0, v0, -0x1

    goto :goto_a

    :cond_18
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "network disconnected, wait"

    new-array v5, v3, [Ljava/lang/Object;

    .line 810
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 811
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V

    .line 812
    monitor-exit v7

    goto/16 :goto_d

    :catchall_7
    move-exception v0

    monitor-exit v7
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_7

    :try_start_11
    throw v0

    :cond_19
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "send succ, remove it"

    new-array v5, v3, [Ljava/lang/Object;

    .line 814
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 815
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v2

    monitor-enter v2
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_9

    :try_start_12
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 816
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/util/LinkedList;->remove(Ljava/lang/Object;)Z

    .line 817
    monitor-exit v2

    goto/16 :goto_d

    :catchall_8
    move-exception v0

    monitor-exit v2
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_8

    :try_start_13
    throw v0
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_9

    :catchall_9
    move-exception v0

    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v5, " run finally error"

    new-array v6, v3, [Ljava/lang/Object;

    .line 820
    invoke-static {v2, v5, v0, v6}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto/16 :goto_d

    :catchall_a
    move-exception v0

    move-object v8, v0

    if-nez v7, :cond_1e

    :try_start_14
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 797
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 798
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    if-eqz v0, :cond_1a

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 799
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    const-string v4, "send fail"

    invoke-virtual {v0, v4}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    :cond_1a
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 801
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v4

    monitor-enter v4
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_d

    :try_start_15
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 802
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/LinkedList;->size()I

    move-result v0

    sub-int/2addr v0, v6

    :goto_b
    if-ltz v0, :cond_1d

    iget-object v6, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 803
    invoke-static {v6}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/util/LinkedList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/taobao/accs/data/Message;

    if-eqz v6, :cond_1c

    .line 804
    iget-object v7, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    if-eqz v7, :cond_1c

    iget-object v7, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    .line 805
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    if-eq v7, v5, :cond_1b

    iget-object v7, v6, Lcom/taobao/accs/data/Message;->t:Ljava/lang/Integer;

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    if-ne v7, v2, :cond_1c

    :cond_1b
    iget-object v7, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 806
    iget-object v7, v7, Lcom/taobao/accs/net/w;->e:Lcom/taobao/accs/data/d;

    sget-object v9, Lcom/taobao/accs/AccsErrorCode;->SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v7, v6, v9}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    iget-object v6, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 807
    invoke-static {v6}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/util/LinkedList;->remove(I)Ljava/lang/Object;

    :cond_1c
    add-int/lit8 v0, v0, -0x1

    goto :goto_b

    :cond_1d
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "network disconnected, wait"

    new-array v5, v3, [Ljava/lang/Object;

    .line 810
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 811
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->wait()V

    .line 812
    monitor-exit v4

    goto :goto_c

    :catchall_b
    move-exception v0

    monitor-exit v4
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_b

    :try_start_16
    throw v0

    :cond_1e
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v2, "send succ, remove it"

    new-array v5, v3, [Ljava/lang/Object;

    .line 814
    invoke-static {v0, v2, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 815
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v2

    monitor-enter v2
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_d

    :try_start_17
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 816
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/util/LinkedList;->remove(Ljava/lang/Object;)Z

    .line 817
    monitor-exit v2

    goto :goto_c

    :catchall_c
    move-exception v0

    monitor-exit v2
    :try_end_17
    .catchall {:try_start_17 .. :try_end_17} :catchall_c

    :try_start_18
    throw v0
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_d

    :catchall_d
    move-exception v0

    iget-object v2, v1, Lcom/taobao/accs/net/w$a;->d:Ljava/lang/String;

    const-string v4, " run finally error"

    new-array v3, v3, [Ljava/lang/Object;

    .line 820
    invoke-static {v2, v4, v0, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 823
    :goto_c
    throw v8

    :cond_1f
    :goto_d
    move-object v0, v4

    goto/16 :goto_0

    :catchall_e
    move-exception v0

    .line 718
    :try_start_19
    monitor-exit v2
    :try_end_19
    .catchall {:try_start_19 .. :try_end_19} :catchall_e

    throw v0

    :cond_20
    :goto_e
    iget-object v0, v1, Lcom/taobao/accs/net/w$a;->c:Lcom/taobao/accs/net/w;

    .line 826
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->q()V

    return-void
.end method
