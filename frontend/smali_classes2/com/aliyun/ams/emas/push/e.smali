.class final Lcom/aliyun/ams/emas/push/e;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/aliyun/ams/emas/push/g;


# instance fields
.field final synthetic a:Ljava/util/Map;

.field final synthetic b:Lcom/aliyun/ams/emas/push/notification/a;

.field final synthetic c:Lcom/aliyun/ams/emas/push/notification/b;

.field final synthetic d:Landroid/content/Context;

.field final synthetic e:Lcom/aliyun/ams/emas/push/IAgooPushCallback;


# direct methods
.method constructor <init>(Ljava/util/Map;Lcom/aliyun/ams/emas/push/notification/a;Lcom/aliyun/ams/emas/push/notification/b;Landroid/content/Context;Lcom/aliyun/ams/emas/push/IAgooPushCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/ams/emas/push/e;->a:Ljava/util/Map;

    iput-object p2, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    iput-object p3, p0, Lcom/aliyun/ams/emas/push/e;->c:Lcom/aliyun/ams/emas/push/notification/b;

    iput-object p4, p0, Lcom/aliyun/ams/emas/push/e;->d:Landroid/content/Context;

    iput-object p5, p0, Lcom/aliyun/ams/emas/push/e;->e:Lcom/aliyun/ams/emas/push/IAgooPushCallback;

    .line 181
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Notification;Landroid/app/Notification;)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/e;->a:Ljava/util/Map;

    const-string v1, "emas_group"

    .line 185
    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 186
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    .line 187
    invoke-virtual {v1, v0}, Lcom/aliyun/ams/emas/push/notification/a;->m(Ljava/lang/String;)V

    .line 190
    :cond_0
    sget-object v0, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "push created notification"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    .line 191
    invoke-virtual {v2}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 190
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/e;->c:Lcom/aliyun/ams/emas/push/notification/b;

    iget-object v1, p0, Lcom/aliyun/ams/emas/push/e;->d:Landroid/content/Context;

    iget-object v2, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    .line 192
    invoke-virtual {v0, v1, p1, p2, v2}, Lcom/aliyun/ams/emas/push/notification/b;->a(Landroid/content/Context;Landroid/app/Notification;Landroid/app/Notification;Lcom/aliyun/ams/emas/push/notification/a;)V

    .line 194
    sget-object p1, Lcom/aliyun/ams/emas/push/h;->importantLogger:Lcom/alibaba/sdk/android/logger/ILog;

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "push onNotificationShow "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    .line 195
    invoke-virtual {v0}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 194
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/ams/emas/push/e;->e:Lcom/aliyun/ams/emas/push/IAgooPushCallback;

    iget-object p2, p0, Lcom/aliyun/ams/emas/push/e;->d:Landroid/content/Context;

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    .line 197
    invoke-virtual {v0}, Lcom/aliyun/ams/emas/push/notification/a;->b()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    invoke-virtual {v1}, Lcom/aliyun/ams/emas/push/notification/a;->c()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/ams/emas/push/e;->b:Lcom/aliyun/ams/emas/push/notification/a;

    .line 198
    invoke-virtual {v2}, Lcom/aliyun/ams/emas/push/notification/a;->e()Ljava/util/Map;

    move-result-object v2

    .line 196
    invoke-interface {p1, p2, v0, v1, v2}, Lcom/aliyun/ams/emas/push/IAgooPushCallback;->onNotificationShow(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V

    return-void
.end method
