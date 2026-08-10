.class public abstract Lcom/alibaba/sdk/android/push/MessageReceiver;
.super Lcom/aliyun/ams/emas/push/AgooMessageReceiver;


# instance fields
.field private final mMessageNotification:Lcom/alibaba/sdk/android/push/notification/d;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/aliyun/ams/emas/push/AgooMessageReceiver;-><init>()V

    new-instance v0, Lcom/alibaba/sdk/android/push/notification/d;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/push/notification/d;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/MessageReceiver;->mMessageNotification:Lcom/alibaba/sdk/android/push/notification/d;

    return-void
.end method


# virtual methods
.method public checkNotificationShowInInnerGroup(Ljava/util/Map;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    invoke-static {}, Lcom/alibaba/sdk/android/push/a/b;->a()Lcom/alibaba/sdk/android/push/a/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/a/b;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v1, "emas_group"

    const-string v2, "emas_accs_push"

    invoke-interface {p1, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return v0
.end method

.method public customNotificationUI(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/PushData;)Landroid/app/Notification;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public customNotificationUI(Landroid/content/Context;Ljava/util/Map;)Landroid/app/Notification;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Landroid/app/Notification;"
        }
    .end annotation

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/notification/PushData;->parse(Landroid/content/Context;Ljava/util/Map;)Lcom/alibaba/sdk/android/push/notification/PushData;

    move-result-object v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/MessageReceiver;->hookNotificationBuild()Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;

    move-result-object v1

    invoke-virtual {p0, p1, v0}, Lcom/alibaba/sdk/android/push/MessageReceiver;->customNotificationUI(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/PushData;)Landroid/app/Notification;

    move-result-object v2

    if-eqz v2, :cond_0

    return-object v2

    :cond_0
    iget-object v2, p0, Lcom/alibaba/sdk/android/push/MessageReceiver;->mMessageNotification:Lcom/alibaba/sdk/android/push/notification/d;

    invoke-virtual {v2, p1, p2}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Ljava/util/Map;)Lcom/alibaba/sdk/android/push/notification/b;

    move-result-object p2

    iget-object v2, p0, Lcom/alibaba/sdk/android/push/MessageReceiver;->mMessageNotification:Lcom/alibaba/sdk/android/push/notification/d;

    invoke-virtual {v2, p1, p2, v0, v1}, Lcom/alibaba/sdk/android/push/notification/d;->b(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object p1

    return-object p1
.end method

.method public customSummaryNotification(Landroid/content/Context;Ljava/util/Map;)Landroid/app/Notification;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Landroid/app/Notification;"
        }
    .end annotation

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/notification/PushData;->parse(Landroid/content/Context;Ljava/util/Map;)Lcom/alibaba/sdk/android/push/notification/PushData;

    move-result-object v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/MessageReceiver;->hookNotificationBuild()Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/push/MessageReceiver;->mMessageNotification:Lcom/alibaba/sdk/android/push/notification/d;

    invoke-virtual {v2, p1, p2}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Ljava/util/Map;)Lcom/alibaba/sdk/android/push/notification/b;

    move-result-object p2

    iget-object v2, p0, Lcom/alibaba/sdk/android/push/MessageReceiver;->mMessageNotification:Lcom/alibaba/sdk/android/push/notification/d;

    invoke-virtual {v2, p1, p2, v0, v1}, Lcom/alibaba/sdk/android/push/notification/d;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/b;Lcom/alibaba/sdk/android/push/notification/PushData;Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;)Landroid/app/Notification;

    move-result-object p1

    return-object p1
.end method

.method public hookNotificationBuild()Lcom/alibaba/sdk/android/push/notification/NotificationConfigure;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method protected abstract onMessage(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/CPushMessage;)V
.end method

.method public onMessageArrived(Landroid/content/Context;Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V
    .locals 0

    invoke-static {p2}, Lcom/alibaba/sdk/android/push/notification/CPushMessage;->from(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)Lcom/alibaba/sdk/android/push/notification/CPushMessage;

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lcom/alibaba/sdk/android/push/MessageReceiver;->onMessage(Landroid/content/Context;Lcom/alibaba/sdk/android/push/notification/CPushMessage;)V

    return-void
.end method

.method protected abstract onNotification(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
.end method

.method protected abstract onNotificationClickedWithNoAction(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method protected abstract onNotificationOpened(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public onNotificationOpened(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1

    const/4 v0, 0x4

    if-ne p5, v0, :cond_0

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/MessageReceiver;->onNotificationClickedWithNoAction(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/MessageReceiver;->onNotificationOpened(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method protected abstract onNotificationReceivedInApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;ILjava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation
.end method

.method public onNotificationReceivedWithoutShow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-virtual/range {p0 .. p7}, Lcom/alibaba/sdk/android/push/MessageReceiver;->onNotificationReceivedInApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method protected abstract onNotificationRemoved(Landroid/content/Context;Ljava/lang/String;)V
.end method

.method public onNotificationRemoved(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-virtual {p0, p1, p6}, Lcom/alibaba/sdk/android/push/MessageReceiver;->onNotificationRemoved(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public onNotificationShow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-eqz p4, :cond_0

    const-string v0, "_ALIYUN_NOTIFICATION_BADGE_"

    invoke-interface {p4, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p4, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {p1, v0}, Lcom/alibaba/sdk/android/push/util/a;->a(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/MessageReceiver;->onNotification(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/aliyun/ams/emas/push/AgooMessageReceiver;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method

.method public showNotificationNow(Landroid/content/Context;Ljava/util/Map;)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    invoke-static {p2}, Lcom/alibaba/sdk/android/push/notification/d;->a(Ljava/util/Map;)Z

    move-result p2

    if-nez p2, :cond_1

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/notification/e;->a(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_0

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
