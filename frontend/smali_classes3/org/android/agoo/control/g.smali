.class Lorg/android/agoo/control/g;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lorg/android/agoo/control/AgooFactory;


# direct methods
.method constructor <init>(Lorg/android/agoo/control/AgooFactory;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lorg/android/agoo/control/g;->c:Lorg/android/agoo/control/AgooFactory;

    iput-object p2, p0, Lorg/android/agoo/control/g;->a:Ljava/lang/String;

    iput-object p3, p0, Lorg/android/agoo/control/g;->b:Ljava/lang/String;

    .line 862
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    const-string v0, "9"

    const-string v1, "AgooFactory"

    const-string v2, "clickMessage,error="

    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 867
    :try_start_0
    sget-object v5, Lcom/taobao/accs/utl/ALog$Level;->I:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v5}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "dismissMessage"

    const/4 v6, 0x4

    new-array v6, v6, [Ljava/lang/Object;

    const-string v7, "msgid"

    aput-object v7, v6, v3

    iget-object v7, p0, Lorg/android/agoo/control/g;->a:Ljava/lang/String;

    const/4 v8, 0x1

    aput-object v7, v6, v8

    const-string v7, "extData"

    const/4 v8, 0x2

    aput-object v7, v6, v8

    iget-object v7, p0, Lorg/android/agoo/control/g;->b:Ljava/lang/String;

    const/4 v8, 0x3

    aput-object v7, v6, v8

    .line 868
    invoke-static {v1, v5, v6}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    const-string v5, "accs"

    iget-object v6, p0, Lorg/android/agoo/control/g;->a:Ljava/lang/String;

    .line 872
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v0, "messageId == null"

    new-array v5, v3, [Ljava/lang/Object;

    .line 873
    invoke-static {v1, v0, v5}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 876
    :cond_1
    new-instance v6, Lorg/android/agoo/common/MsgDO;

    invoke-direct {v6}, Lorg/android/agoo/common/MsgDO;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v4, p0, Lorg/android/agoo/control/g;->a:Ljava/lang/String;

    .line 877
    iput-object v4, v6, Lorg/android/agoo/common/MsgDO;->msgIds:Ljava/lang/String;

    iget-object v4, p0, Lorg/android/agoo/control/g;->b:Ljava/lang/String;

    .line 878
    iput-object v4, v6, Lorg/android/agoo/common/MsgDO;->extData:Ljava/lang/String;

    .line 879
    iput-object v5, v6, Lorg/android/agoo/common/MsgDO;->messageSource:Ljava/lang/String;

    .line 880
    iput-object v0, v6, Lorg/android/agoo/common/MsgDO;->msgStatus:Ljava/lang/String;

    iget-object v4, p0, Lorg/android/agoo/control/g;->c:Lorg/android/agoo/control/AgooFactory;

    iget-object v5, p0, Lorg/android/agoo/control/g;->a:Ljava/lang/String;

    .line 882
    invoke-virtual {v4, v5, v0}, Lorg/android/agoo/control/AgooFactory;->updateMsgStatus(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    iget-object v0, p0, Lorg/android/agoo/control/g;->c:Lorg/android/agoo/control/AgooFactory;

    .line 887
    invoke-static {v0}, Lorg/android/agoo/control/AgooFactory;->access$200(Lorg/android/agoo/control/AgooFactory;)Lorg/android/agoo/control/NotifManager;

    move-result-object v0

    invoke-virtual {v0, v6}, Lorg/android/agoo/control/NotifManager;->reportNotifyMessage(Lorg/android/agoo/common/MsgDO;)V

    goto :goto_1

    :catchall_0
    move-exception v0

    move-object v4, v6

    goto :goto_0

    :catchall_1
    move-exception v0

    .line 884
    :goto_0
    :try_start_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v1, v0, v2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-eqz v4, :cond_2

    iget-object v0, p0, Lorg/android/agoo/control/g;->c:Lorg/android/agoo/control/AgooFactory;

    .line 887
    invoke-static {v0}, Lorg/android/agoo/control/AgooFactory;->access$200(Lorg/android/agoo/control/AgooFactory;)Lorg/android/agoo/control/NotifManager;

    move-result-object v0

    invoke-virtual {v0, v4}, Lorg/android/agoo/control/NotifManager;->reportNotifyMessage(Lorg/android/agoo/common/MsgDO;)V

    :cond_2
    :goto_1
    return-void

    :catchall_2
    move-exception v0

    if-eqz v4, :cond_3

    iget-object v1, p0, Lorg/android/agoo/control/g;->c:Lorg/android/agoo/control/AgooFactory;

    invoke-static {v1}, Lorg/android/agoo/control/AgooFactory;->access$200(Lorg/android/agoo/control/AgooFactory;)Lorg/android/agoo/control/NotifManager;

    move-result-object v1

    invoke-virtual {v1, v4}, Lorg/android/agoo/control/NotifManager;->reportNotifyMessage(Lorg/android/agoo/common/MsgDO;)V

    .line 889
    :cond_3
    throw v0
.end method
