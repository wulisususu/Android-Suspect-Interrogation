.class final Lcom/aliyun/ams/emas/push/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/aliyun/ams/emas/push/IAgooPushConfig;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Ljava/util/Map;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Z

.field final synthetic f:Landroid/os/Handler;

.field final synthetic g:Lcom/aliyun/ams/emas/push/g;


# direct methods
.method constructor <init>(Lcom/aliyun/ams/emas/push/IAgooPushConfig;Landroid/content/Context;Ljava/util/Map;Ljava/lang/String;ZLandroid/os/Handler;Lcom/aliyun/ams/emas/push/g;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/ams/emas/push/c;->a:Lcom/aliyun/ams/emas/push/IAgooPushConfig;

    iput-object p2, p0, Lcom/aliyun/ams/emas/push/c;->b:Landroid/content/Context;

    iput-object p3, p0, Lcom/aliyun/ams/emas/push/c;->c:Ljava/util/Map;

    iput-object p4, p0, Lcom/aliyun/ams/emas/push/c;->d:Ljava/lang/String;

    iput-boolean p5, p0, Lcom/aliyun/ams/emas/push/c;->e:Z

    iput-object p6, p0, Lcom/aliyun/ams/emas/push/c;->f:Landroid/os/Handler;

    iput-object p7, p0, Lcom/aliyun/ams/emas/push/c;->g:Lcom/aliyun/ams/emas/push/g;

    .line 131
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/c;->a:Lcom/aliyun/ams/emas/push/IAgooPushConfig;

    iget-object v1, p0, Lcom/aliyun/ams/emas/push/c;->b:Landroid/content/Context;

    iget-object v2, p0, Lcom/aliyun/ams/emas/push/c;->c:Ljava/util/Map;

    .line 134
    invoke-interface {v0, v1, v2}, Lcom/aliyun/ams/emas/push/IAgooPushConfig;->customNotificationUI(Landroid/content/Context;Ljava/util/Map;)Landroid/app/Notification;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/ams/emas/push/c;->d:Ljava/lang/String;

    .line 137
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-boolean v1, p0, Lcom/aliyun/ams/emas/push/c;->e:Z

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    iget-object v1, p0, Lcom/aliyun/ams/emas/push/c;->a:Lcom/aliyun/ams/emas/push/IAgooPushConfig;

    iget-object v2, p0, Lcom/aliyun/ams/emas/push/c;->b:Landroid/content/Context;

    iget-object v3, p0, Lcom/aliyun/ams/emas/push/c;->c:Ljava/util/Map;

    .line 138
    invoke-interface {v1, v2, v3}, Lcom/aliyun/ams/emas/push/IAgooPushConfig;->customSummaryNotification(Landroid/content/Context;Ljava/util/Map;)Landroid/app/Notification;

    move-result-object v1

    :goto_1
    iget-object v2, p0, Lcom/aliyun/ams/emas/push/c;->f:Landroid/os/Handler;

    if-eqz v2, :cond_2

    .line 143
    new-instance v3, Lcom/aliyun/ams/emas/push/d;

    invoke-direct {v3, p0, v0, v1}, Lcom/aliyun/ams/emas/push/d;-><init>(Lcom/aliyun/ams/emas/push/c;Landroid/app/Notification;Landroid/app/Notification;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_2

    :cond_2
    iget-object v2, p0, Lcom/aliyun/ams/emas/push/c;->g:Lcom/aliyun/ams/emas/push/g;

    .line 151
    invoke-interface {v2, v0, v1}, Lcom/aliyun/ams/emas/push/g;->a(Landroid/app/Notification;Landroid/app/Notification;)V

    :goto_2
    return-void
.end method
