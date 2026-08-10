.class Lanet/channel/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/entity/EventCb;


# instance fields
.field final synthetic a:Lanet/channel/SessionRequest$IConnCb;

.field final synthetic b:J

.field final synthetic c:Lanet/channel/SessionRequest;


# direct methods
.method constructor <init>(Lanet/channel/SessionRequest;Lanet/channel/SessionRequest$IConnCb;J)V
    .locals 0

    iput-object p1, p0, Lanet/channel/f;->c:Lanet/channel/SessionRequest;

    iput-object p2, p0, Lanet/channel/f;->a:Lanet/channel/SessionRequest$IConnCb;

    iput-wide p3, p0, Lanet/channel/f;->b:J

    .line 581
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEvent(Lanet/channel/Session;ILanet/channel/entity/b;)V
    .locals 14

    move-object v0, p0

    move-object v7, p1

    move/from16 v8, p2

    move-object/from16 v6, p3

    if-nez v7, :cond_0

    return-void

    :cond_0
    const/4 v9, 0x0

    if-nez v6, :cond_1

    move v10, v9

    goto :goto_0

    .line 587
    :cond_1
    iget v1, v6, Lanet/channel/entity/b;->b:I

    move v10, v1

    :goto_0
    if-nez v6, :cond_2

    const-string v1, ""

    goto :goto_1

    .line 588
    :cond_2
    iget-object v1, v6, Lanet/channel/entity/b;->c:Ljava/lang/String;

    :goto_1
    move-object v11, v1

    const/4 v1, 0x2

    const-string v12, "awcn.SessionRequest"

    const/4 v13, 0x0

    if-eq v8, v1, :cond_7

    const/16 v1, 0x100

    if-eq v8, v1, :cond_5

    const/16 v1, 0x200

    if-eq v8, v1, :cond_3

    goto/16 :goto_5

    :cond_3
    if-eqz v7, :cond_4

    .line 591
    iget-object v1, v7, Lanet/channel/Session;->p:Ljava/lang/String;

    move-object v10, v1

    goto :goto_2

    :cond_4
    move-object v10, v13

    :goto_2
    const-string v1, "Session"

    const-string v3, "EventType"

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const-string v5, "Event"

    move-object v2, p1

    move-object/from16 v6, p3

    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v12, v13, v10, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, v0, Lanet/channel/f;->c:Lanet/channel/SessionRequest;

    .line 1060
    invoke-virtual {v1, p1, v9, v13}, Lanet/channel/SessionRequest;->a(Lanet/channel/Session;ILjava/lang/String;)V

    iget-object v1, v0, Lanet/channel/f;->a:Lanet/channel/SessionRequest$IConnCb;

    iget-wide v2, v0, Lanet/channel/f;->b:J

    .line 593
    invoke-interface {v1, p1, v2, v3}, Lanet/channel/SessionRequest$IConnCb;->onSuccess(Lanet/channel/Session;J)V

    goto/16 :goto_5

    :cond_5
    if-eqz v7, :cond_6

    .line 605
    iget-object v1, v7, Lanet/channel/Session;->p:Ljava/lang/String;

    move-object v9, v1

    goto :goto_3

    :cond_6
    move-object v9, v13

    :goto_3
    const-string v1, "Session"

    const-string v3, "EventType"

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const-string v5, "Event"

    move-object v2, p1

    move-object/from16 v6, p3

    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v12, v13, v9, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, v0, Lanet/channel/f;->a:Lanet/channel/SessionRequest$IConnCb;

    iget-wide v3, v0, Lanet/channel/f;->b:J

    move/from16 v5, p2

    move v6, v10

    .line 606
    invoke-interface/range {v1 .. v6}, Lanet/channel/SessionRequest$IConnCb;->onFailed(Lanet/channel/Session;JII)V

    goto :goto_5

    :cond_7
    if-eqz v7, :cond_8

    .line 596
    iget-object v1, v7, Lanet/channel/Session;->p:Ljava/lang/String;

    move-object v9, v1

    goto :goto_4

    :cond_8
    move-object v9, v13

    :goto_4
    const-string v1, "Session"

    const-string v3, "EventType"

    invoke-static/range {p2 .. p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const-string v5, "Event"

    move-object v2, p1

    move-object/from16 v6, p3

    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v12, v13, v9, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, v0, Lanet/channel/f;->c:Lanet/channel/SessionRequest;

    .line 2060
    invoke-virtual {v1, p1, v10, v11}, Lanet/channel/SessionRequest;->a(Lanet/channel/Session;ILjava/lang/String;)V

    iget-object v1, v0, Lanet/channel/f;->c:Lanet/channel/SessionRequest;

    .line 3060
    iget-object v1, v1, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    iget-object v2, v0, Lanet/channel/f;->c:Lanet/channel/SessionRequest;

    .line 598
    invoke-virtual {v1, v2, p1}, Lanet/channel/e;->c(Lanet/channel/SessionRequest;Lanet/channel/Session;)Z

    move-result v1

    if-eqz v1, :cond_9

    iget-object v1, v0, Lanet/channel/f;->a:Lanet/channel/SessionRequest$IConnCb;

    iget-wide v2, v0, Lanet/channel/f;->b:J

    .line 599
    invoke-interface {v1, p1, v2, v3, v8}, Lanet/channel/SessionRequest$IConnCb;->onDisConnect(Lanet/channel/Session;JI)V

    goto :goto_5

    :cond_9
    iget-object v1, v0, Lanet/channel/f;->a:Lanet/channel/SessionRequest$IConnCb;

    iget-wide v3, v0, Lanet/channel/f;->b:J

    move-object v2, p1

    move/from16 v5, p2

    move v6, v10

    .line 601
    invoke-interface/range {v1 .. v6}, Lanet/channel/SessionRequest$IConnCb;->onFailed(Lanet/channel/Session;JII)V

    :goto_5
    return-void
.end method
