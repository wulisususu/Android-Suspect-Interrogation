.class public abstract Lcom/alibaba/sdk/android/settingservice/EmasSettingService;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/settingservice/Initializer;
.implements Lcom/alibaba/sdk/android/settingservice/PreLoader;
.implements Lcom/alibaba/sdk/android/settingservice/SettingQuerier;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/EmasSettingService;
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/settingservice/b/c;->a()Lcom/alibaba/sdk/android/settingservice/b/c;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/alibaba/sdk/android/settingservice/b/c;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/b/a;

    move-result-object p0

    return-object p0
.end method
