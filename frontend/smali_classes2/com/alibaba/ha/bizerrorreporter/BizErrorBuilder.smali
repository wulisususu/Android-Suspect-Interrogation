.class public Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;
.super Ljava/lang/Object;
.source "BizErrorBuilder.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;,
        Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$SimpleJavaExceptionReportBuilder;,
        Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$ReportBuilder;
    }
.end annotation


# static fields
.field public static final _JAVA_VERSION:Ljava/lang/String; = ""

.field public static final _MAGIC:Ljava/lang/String; = "BizErrorReporterSDK"

.field public static final _NATIVE_VERSION:Ljava/lang/String; = "160509105620"

.field public static final _TARGET:Ljava/lang/String; = "beta"

.field public static final _VERSION:Ljava/lang/String; = "1.0.0.0"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static buildReportName(Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "appKey",
            "appVersion",
            "timestamp",
            "tag",
            "reportType"
        }
    .end annotation

    .line 604
    invoke-static {p1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;->replaceUnderscore(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 605
    invoke-static {p4}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;->replaceUnderscore(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p4

    .line 607
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "BizErrorReporterSDK_1.0.0.0_df_df_df_df_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "_"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 615
    invoke-static {p2, p3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 616
    invoke-static {p2, p3}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;->getGMT8Time(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, "df"

    .line 617
    invoke-static {p4, p1}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->defaultString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ".log"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static getGMT8Time(J)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "timestamp"
        }
    .end annotation

    .line 638
    :try_start_0
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string/jumbo v1, "yyyyMMddHHmmss"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    const-string v1, "GMT+8"

    .line 639
    invoke-static {v1}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    .line 640
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1, p0, p1}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    const-string p1, "MotuCrashAdapter"

    const-string v0, "getGMT8Time"

    .line 642
    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string p0, ""

    return-object p0
.end method

.method public static replaceUnderscore(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "str"
        }
    .end annotation

    if-eqz p0, :cond_0

    const-string v0, "_"

    const-string v1, "&#95;"

    .line 627
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_0
    const-string p0, ""

    :goto_0
    return-object p0
.end method


# virtual methods
.method public build(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)Lcom/alibaba/ha/bizerrorreporter/module/SendModule;
    .locals 11
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "mContext",
            "exceptionModule"
        }
    .end annotation

    .line 57
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;

    invoke-direct {v0}, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;-><init>()V

    .line 59
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    const-string v5, "catch"

    const-string v9, "BUSINESS"

    .line 62
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    .line 63
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v2

    iget-object v2, v2, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    move-wide v3, v7

    move-object v6, v9

    .line 62
    invoke-static/range {v1 .. v6}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;->buildReportName(Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 67
    new-instance v10, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;

    move-object v1, v10

    move-object v2, p0

    move-object v3, p2

    move-object v4, p1

    move-wide v6, v7

    move-object v8, v9

    invoke-direct/range {v1 .. v8}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$JavaExceptionReportBuilder;-><init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;)V

    .line 70
    :try_start_0
    invoke-virtual {v10}, Lcom/alibaba/ha/bizerrorreporter/BizErrorBuilder$ReportBuilder;->builder()Ljava/lang/String;

    move-result-object p1

    .line 71
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/GzipUtils;->gzip([B)[B

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/Base64;->encodeBase64String([B)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->sendContent:Ljava/lang/String;

    .line 72
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->aggregationType:Ljava/lang/String;

    .line 73
    iget-object p1, p2, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->businessType:Ljava/lang/String;

    .line 74
    sget-object p1, Lcom/alibaba/ha/bizerrorreporter/BizErrorConstants;->EVENTID_61005:Ljava/lang/Integer;

    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->eventId:Ljava/lang/Integer;

    const-string p1, "MOTU_REPORTER_SDK_3.0.0_PRIVATE_COMPRESS"

    .line 75
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/SendModule;->sendFlag:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p1

    const-string p2, "MotuCrashAdapter"

    const-string v0, "base64 and gzip err"

    .line 79
    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p1, 0x0

    return-object p1
.end method
