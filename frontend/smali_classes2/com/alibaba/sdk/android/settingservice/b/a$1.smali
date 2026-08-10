.class Lcom/alibaba/sdk/android/settingservice/b/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/settingservice/a/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/settingservice/b/a;->getObject(Ljava/lang/String;Ljava/lang/Class;Lcom/alibaba/sdk/android/settingservice/SettingCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/Class;

.field final synthetic c:Z

.field final synthetic d:Lcom/alibaba/sdk/android/settingservice/SettingCallback;

.field final synthetic e:Lcom/alibaba/sdk/android/settingservice/b/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/settingservice/b/a;Ljava/lang/String;Ljava/lang/Class;ZLcom/alibaba/sdk/android/settingservice/SettingCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->e:Lcom/alibaba/sdk/android/settingservice/b/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->a:Ljava/lang/String;

    iput-object p3, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->b:Ljava/lang/Class;

    iput-boolean p4, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->c:Z

    iput-object p5, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->d:Lcom/alibaba/sdk/android/settingservice/SettingCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->e:Lcom/alibaba/sdk/android/settingservice/b/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->b:Ljava/lang/Class;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lcom/alibaba/sdk/android/settingservice/b/a;->a(Lcom/alibaba/sdk/android/settingservice/b/a;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object v0

    iget-boolean v1, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->c:Z

    if-nez v1, :cond_1

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->d:Lcom/alibaba/sdk/android/settingservice/SettingCallback;

    iget-object v2, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->a:Ljava/lang/String;

    invoke-interface {v1, v2, v0}, Lcom/alibaba/sdk/android/settingservice/SettingCallback;->onSuccess(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/a$1;->d:Lcom/alibaba/sdk/android/settingservice/SettingCallback;

    invoke-interface {v0}, Lcom/alibaba/sdk/android/settingservice/SettingCallback;->onFail()V

    :cond_1
    :goto_0
    return-void
.end method
