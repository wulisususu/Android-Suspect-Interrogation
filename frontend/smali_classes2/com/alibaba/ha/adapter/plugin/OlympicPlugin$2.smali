.class public Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;
.super Ljava/lang/Object;
.source "OlympicPlugin.java"

# interfaces
.implements Lcom/alibaba/sdk/android/settingservice/SettingCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->updateSample(Lcom/alibaba/ha/protocol/AliHaParam;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/alibaba/sdk/android/settingservice/SettingCallback<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

.field public final synthetic val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    iput-object p2, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    .line 225
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFail()V
    .locals 0

    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0

    .line 225
    check-cast p2, Ljava/lang/String;

    invoke-virtual {p0, p1, p2}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;->onSuccess(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSuccess(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 228
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    .line 229
    invoke-static {p1, p2}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->access$200(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$2;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    .line 230
    iget-object p1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    const-string v0, "emas_crash_sample"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    .line 231
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "crash_sampling_rate"

    invoke-interface {p1, v0, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_0
    return-void
.end method
