.class public Lcom/aliyun/emas/apm/crash/p;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/p$a;
    }
.end annotation


# static fields
.field private static final a:Lcom/google/firebase/encoders/DataEncoder;


# direct methods
.method public static synthetic $r8$lambda$I21gb-B5N2-k3Muqn8RE6uoi0qw(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->c(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$O3I2FI3DSDkOf95LMKmYxTwugiA(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->d(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$O4XhSUPn6gdUPNaTLmJn6_Lzyzg(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->k(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$chXClaCg_YJ90dlD1RVnRhK2-C8(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->f(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$hiXOGmrFSJ9Es16AIt02BVbAwn0(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->m(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$l7ZD8ZoZB5xuXCV4Ax_dQ5xuFTM(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->p(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$lo3X-b9_AaZxNJ-5I_jUrp9y_Oc(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->o(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$qLuVwf8i_Amg9xmEF-s1rN0v2jo(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->s(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    invoke-direct {v0}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;-><init>()V

    sget-object v1, Lcom/aliyun/emas/apm/crash/internal/model/a;->a:Lcom/google/firebase/encoders/config/Configurator;

    .line 3
    invoke-virtual {v0, v1}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->configureWith(Lcom/google/firebase/encoders/config/Configurator;)Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    move-result-object v0

    const/4 v1, 0x1

    .line 4
    invoke-virtual {v0, v1}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->ignoreNullValues(Z)Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    move-result-object v0

    .line 5
    invoke-virtual {v0}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->build()Lcom/google/firebase/encoders/DataEncoder;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/p;->a:Lcom/google/firebase/encoders/DataEncoder;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;
    .locals 4

    .line 11
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v0

    .line 13
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 14
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 15
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 16
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "channel"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x6

    goto :goto_1

    :sswitch_1
    const-string v2, "version"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_2
    const-string v2, "developmentPlatformVersion"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_3
    const-string v2, "build"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_4
    const-string v2, "name"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_5
    const-string v2, "developmentPlatform"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_6
    const-string v2, "debuggable"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto :goto_1

    :cond_6
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    goto :goto_2

    .line 27
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setChannel(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    goto :goto_0

    .line 28
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    goto :goto_0

    .line 43
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setDevelopmentPlatformVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    .line 45
    :goto_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 46
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setBuild(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    goto/16 :goto_0

    .line 47
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    goto/16 :goto_0

    .line 62
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setDevelopmentPlatform(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    goto/16 :goto_0

    .line 63
    :pswitch_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setDebuggable(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    goto/16 :goto_0

    .line 76
    :cond_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 78
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x6d479032 -> :sswitch_6
        -0x1ef60132 -> :sswitch_5
        0x337a8b -> :sswitch_4
        0x59bc66e -> :sswitch_3
        0xcbc122a -> :sswitch_2
        0x14f51cd8 -> :sswitch_1
        0x2c0b7d03 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;
    .locals 2

    .line 79
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 81
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginArray()V

    .line 82
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 83
    invoke-interface {p1, p0}, Lcom/aliyun/emas/apm/crash/p$a;->a(Landroid/util/JsonReader;)Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 85
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->endArray()V

    .line 87
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method private static b(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;
    .locals 4

    .line 8
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v0

    .line 10
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 11
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_9

    .line 12
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 13
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    const-string v2, "importance"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_1

    :cond_0
    const/16 v3, 0x8

    goto/16 :goto_1

    :sswitch_1
    const-string v2, "traceFile"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x7

    goto :goto_1

    :sswitch_2
    const-string v2, "reasonCode"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x6

    goto :goto_1

    :sswitch_3
    const-string v2, "processName"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_4
    const-string v2, "timestamp"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_5
    const-string v2, "rss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_6
    const-string v2, "pss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto :goto_1

    :cond_6
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_7
    const-string v2, "pid"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    goto :goto_1

    :cond_7
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_8
    const-string v2, "buildIdMappingForArch"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    goto :goto_1

    :cond_8
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 44
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 45
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 57
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setTraceFile(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 58
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setReasonCode(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 59
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setProcessName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 74
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 75
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setRss(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 76
    :pswitch_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setPss(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 77
    :pswitch_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setPid(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 101
    :pswitch_8
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda5;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda5;-><init>()V

    .line 102
    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 103
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setBuildIdMappingForArch(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    goto/16 :goto_0

    .line 111
    :cond_9
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 112
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x5a5f6366 -> :sswitch_8
        0x1b18b -> :sswitch_7
        0x1b2d0 -> :sswitch_6
        0x1ba52 -> :sswitch_5
        0x3492916 -> :sswitch_4
        0xc0f3d9a -> :sswitch_3
        0x2b0af251 -> :sswitch_2
        0x2b253061 -> :sswitch_1
        0x7eb2da74 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static c(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch;
    .locals 4

    .line 8
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;

    move-result-object v0

    .line 10
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 11
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 12
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 13
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "buildId"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_1
    const-string v2, "arch"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_2
    const-string v2, "libraryName"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 25
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 26
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;->setBuildId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;

    goto :goto_0

    .line 27
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;->setArch(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;

    goto :goto_0

    .line 28
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;->setLibraryName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;

    goto :goto_0

    .line 41
    :cond_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 42
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x2459c21a -> :sswitch_2
        0x2dd056 -> :sswitch_1
        0xdc3ec29 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static d(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "key"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "value"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;->setValue(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;

    goto :goto_0

    .line 16
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;->setKey(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;

    goto :goto_0

    .line 26
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 27
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;

    move-result-object p0

    return-object p0
.end method

.method private static e(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_f

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    const-string v2, "modelClass"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_1

    :cond_0
    const/16 v3, 0xe

    goto/16 :goto_1

    :sswitch_1
    const-string v2, "version"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto/16 :goto_1

    :cond_1
    const/16 v3, 0xd

    goto/16 :goto_1

    :sswitch_2
    const-string v2, "state"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto/16 :goto_1

    :cond_2
    const/16 v3, 0xc

    goto/16 :goto_1

    :sswitch_3
    const-string v2, "model"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto/16 :goto_1

    :cond_3
    const/16 v3, 0xb

    goto/16 :goto_1

    :sswitch_4
    const-string v2, "cores"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto/16 :goto_1

    :cond_4
    const/16 v3, 0xa

    goto/16 :goto_1

    :sswitch_5
    const-string v2, "brand"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto/16 :goto_1

    :cond_5
    const/16 v3, 0x9

    goto/16 :goto_1

    :sswitch_6
    const-string v2, "diskSpace"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto/16 :goto_1

    :cond_6
    const/16 v3, 0x8

    goto/16 :goto_1

    :sswitch_7
    const-string v2, "arch"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    goto :goto_1

    :cond_7
    const/4 v3, 0x7

    goto :goto_1

    :sswitch_8
    const-string v2, "ram"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    goto :goto_1

    :cond_8
    const/4 v3, 0x6

    goto :goto_1

    :sswitch_9
    const-string v2, "os"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    goto :goto_1

    :cond_9
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_a
    const-string v2, "jailbroken"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_a

    goto :goto_1

    :cond_a
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_b
    const-string v2, "resolution"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    goto :goto_1

    :cond_b
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_c
    const-string v2, "language"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_c

    goto :goto_1

    :cond_c
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_d
    const-string v2, "manufacturer"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    goto :goto_1

    :cond_d
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_e
    const-string v2, "simulator"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_e

    goto :goto_1

    :cond_e
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 54
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 55
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setModelClass(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 56
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 80
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setState(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 81
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setModel(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 99
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setCores(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 100
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setBrand(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 127
    :pswitch_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setDiskSpace(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 128
    :pswitch_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setArch(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 134
    :pswitch_8
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setRam(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 135
    :pswitch_9
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setOs(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 171
    :pswitch_a
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setJailbroken(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 172
    :pswitch_b
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setResolution(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 173
    :pswitch_c
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setLanguage(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 197
    :pswitch_d
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setManufacturer(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 198
    :pswitch_e
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setSimulator(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    goto/16 :goto_0

    .line 218
    :cond_f
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 220
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x7618bbfc -> :sswitch_e
        -0x7561dc2f -> :sswitch_d
        -0x602d6ca8 -> :sswitch_c
        -0x5f5e8754 -> :sswitch_b
        -0x11773b11 -> :sswitch_a
        0xde4 -> :sswitch_9
        0x1b81e -> :sswitch_8
        0x2dd056 -> :sswitch_7
        0x4dfed69 -> :sswitch_6
        0x59a4b87 -> :sswitch_5
        0x5a744b4 -> :sswitch_4
        0x633fb29 -> :sswitch_3
        0x68ac491 -> :sswitch_2
        0x14f51cd8 -> :sswitch_1
        0x7bea4fcf -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static f(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 5

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, 0x2

    const/4 v4, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "timestamp"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v4, 0x6

    goto :goto_1

    :sswitch_1
    const-string v2, "type"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v4, 0x5

    goto :goto_1

    :sswitch_2
    const-string v2, "app"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v4, 0x4

    goto :goto_1

    :sswitch_3
    const-string v2, "rollouts"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v4, 0x3

    goto :goto_1

    :sswitch_4
    const-string v2, "memory"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    move v4, v3

    goto :goto_1

    :sswitch_5
    const-string v2, "logcat"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    const/4 v4, 0x1

    goto :goto_1

    :sswitch_6
    const-string v2, "device"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto :goto_1

    :cond_6
    const/4 v4, 0x0

    :goto_1
    packed-switch v4, :pswitch_data_0

    .line 30
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 31
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto :goto_0

    .line 34
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto :goto_0

    .line 37
    :pswitch_2
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->g(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto/16 :goto_0

    .line 46
    :pswitch_3
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->n(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setRollouts(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto/16 :goto_0

    .line 47
    :pswitch_4
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->l(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setMemory(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto/16 :goto_0

    .line 53
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setLogcat([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto/16 :goto_0

    .line 54
    :pswitch_6
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->h(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    goto/16 :goto_0

    .line 70
    :cond_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 71
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x4f94e1aa -> :sswitch_6
        -0x416819ee -> :sswitch_5
        -0x403d42ff -> :sswitch_4
        -0xf74cb1e -> :sswitch_3
        0x17a21 -> :sswitch_2
        0x368f3a -> :sswitch_1
        0x3492916 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static g(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_9

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    const-string v2, "currentProcessDetails"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_1

    :cond_0
    const/16 v3, 0x8

    goto/16 :goto_1

    :sswitch_1
    const-string v2, "network"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x7

    goto :goto_1

    :sswitch_2
    const-string v2, "uiOrientation"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x6

    goto :goto_1

    :sswitch_3
    const-string v2, "customAttributes"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_4
    const-string v2, "user"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_5
    const-string v2, "internalKeys"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_6
    const-string v2, "execution"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto :goto_1

    :cond_6
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_7
    const-string v2, "background"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    goto :goto_1

    :cond_7
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_8
    const-string v2, "appProcessDetails"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    goto :goto_1

    :cond_8
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 39
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 40
    :pswitch_0
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->s(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setCurrentProcessDetails(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 47
    :pswitch_1
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->r(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 48
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setUiOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 54
    :pswitch_3
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda0;-><init>()V

    .line 55
    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 56
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setCustomAttributes(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 74
    :pswitch_4
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->y(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 75
    :pswitch_5
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda0;-><init>()V

    .line 76
    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 77
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setInternalKeys(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 78
    :pswitch_6
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->i(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setExecution(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 79
    :pswitch_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setBackground(Ljava/lang/Boolean;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 99
    :pswitch_8
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda1;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda1;-><init>()V

    .line 100
    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 101
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setAppProcessDetails(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    goto/16 :goto_0

    .line 115
    :cond_9
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 116
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x53c366ac -> :sswitch_8
        -0x4f67aad2 -> :sswitch_7
        -0x4106f4e8 -> :sswitch_6
        -0x4c83daf -> :sswitch_5
        0x36ebcb -> :sswitch_4
        0x211737a8 -> :sswitch_3
        0x375b6a9c -> :sswitch_2
        0x6de15a2e -> :sswitch_1
        0x6e2222ac -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static h(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "proximityOn"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_1
    const-string v2, "ramUsed"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_2
    const-string v2, "diskUsed"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_3
    const-string v2, "orientation"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_4
    const-string v2, "batteryVelocity"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_5
    const-string v2, "batteryLevel"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 27
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 28
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setProximityOn(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    goto :goto_0

    .line 34
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setRamUsed(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    goto :goto_0

    .line 35
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setDiskUsed(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    goto :goto_0

    .line 41
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    goto/16 :goto_0

    .line 42
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setBatteryVelocity(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    goto/16 :goto_0

    .line 43
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextDouble()D

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setBatteryLevel(Ljava/lang/Double;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    goto/16 :goto_0

    .line 65
    :cond_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 66
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x65d74289 -> :sswitch_5
        -0x56c20df6 -> :sswitch_4
        -0x55cd0a30 -> :sswitch_3
        0x10ad56fa -> :sswitch_2
        0x3a34d8fb -> :sswitch_1
        0x5a6876be -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static i(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "exception"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_1
    const-string v2, "threads"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_2
    const-string v2, "appExitInfo"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_3
    const-string v2, "ndkPayload"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 22
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 23
    :pswitch_0
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->j(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setException(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    goto :goto_0

    .line 24
    :pswitch_1
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda2;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda2;-><init>()V

    .line 25
    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 26
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setThreads(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    goto :goto_0

    .line 36
    :pswitch_2
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->b(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setAppExitInfo(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    goto :goto_0

    .line 37
    :pswitch_3
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->q(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setNdkPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    goto :goto_0

    .line 47
    :cond_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 48
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x7e43cda7 -> :sswitch_3
        -0x51f6ffd3 -> :sswitch_2
        -0x4fbf4c57 -> :sswitch_1
        0x584fd04f -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static j(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "overflowCount"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_1
    const-string v2, "causedBy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_2
    const-string v2, "type"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_3
    const-string v2, "reason"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_4
    const-string v2, "frames"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 25
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 26
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setOverflowCount(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    goto :goto_0

    .line 27
    :pswitch_1
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->j(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setCausedBy(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    goto :goto_0

    .line 37
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    goto :goto_0

    .line 40
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setReason(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    goto :goto_0

    .line 41
    :pswitch_4
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda4;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda4;-><init>()V

    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 42
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_5

    const/4 v1, 0x0

    :cond_5
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setFrames(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    goto/16 :goto_0

    .line 58
    :cond_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 59
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x4b7d7b5a -> :sswitch_4
        -0x37ba6dbc -> :sswitch_3
        0x368f3a -> :sswitch_2
        0x57bc6d2 -> :sswitch_1
        0x22acde2d -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static k(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_5

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "importance"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_1
    const-string v2, "file"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_2
    const-string v2, "pc"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_3
    const-string v2, "symbol"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_4
    const-string v2, "offset"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 24
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 25
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    goto :goto_0

    .line 28
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setFile(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    goto :goto_0

    .line 34
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setPc(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    goto :goto_0

    .line 37
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setSymbol(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    goto :goto_0

    .line 38
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setOffset(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    goto :goto_0

    .line 51
    :cond_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 52
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x3cc89b6d -> :sswitch_4
        -0x34e68a68 -> :sswitch_3
        0xdf3 -> :sswitch_2
        0x2ff57c -> :sswitch_1
        0x7eb2da74 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static l(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_10

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    const-string v2, "memoryStat"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_1

    :cond_0
    const/16 v3, 0xf

    goto/16 :goto_1

    :sswitch_1
    const-string v2, "dalvikPss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto/16 :goto_1

    :cond_1
    const/16 v3, 0xe

    goto/16 :goto_1

    :sswitch_2
    const-string v2, "otherSharedDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto/16 :goto_1

    :cond_2
    const/16 v3, 0xd

    goto/16 :goto_1

    :sswitch_3
    const-string v2, "otherPrivateDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto/16 :goto_1

    :cond_3
    const/16 v3, 0xc

    goto/16 :goto_1

    :sswitch_4
    const-string v2, "nativeSharedDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto/16 :goto_1

    :cond_4
    const/16 v3, 0xb

    goto/16 :goto_1

    :sswitch_5
    const-string v2, "totalPss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto/16 :goto_1

    :cond_5
    const/16 v3, 0xa

    goto/16 :goto_1

    :sswitch_6
    const-string v2, "nativePss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto/16 :goto_1

    :cond_6
    const/16 v3, 0x9

    goto/16 :goto_1

    :sswitch_7
    const-string v2, "otherPss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    goto/16 :goto_1

    :cond_7
    const/16 v3, 0x8

    goto/16 :goto_1

    :sswitch_8
    const-string v2, "totalSharedDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    goto :goto_1

    :cond_8
    const/4 v3, 0x7

    goto :goto_1

    :sswitch_9
    const-string v2, "totalSharedClean"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    goto :goto_1

    :cond_9
    const/4 v3, 0x6

    goto :goto_1

    :sswitch_a
    const-string v2, "totalSwappablePss"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_a

    goto :goto_1

    :cond_a
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_b
    const-string v2, "nativePrivateDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    goto :goto_1

    :cond_b
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_c
    const-string v2, "dalvikSharedDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_c

    goto :goto_1

    :cond_c
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_d
    const-string v2, "totalPrivateDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    goto :goto_1

    :cond_d
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_e
    const-string v2, "totalPrivateClean"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_e

    goto :goto_1

    :cond_e
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_f
    const-string v2, "dalvikPrivateDirty"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_f

    goto :goto_1

    :cond_f
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 57
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 58
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setMemoryStat(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 59
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setDalvikPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 80
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setOtherSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 81
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setOtherPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 82
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setNativeSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 106
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 107
    :pswitch_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setNativePss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 116
    :pswitch_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setOtherPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 128
    :pswitch_8
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 131
    :pswitch_9
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalSharedClean(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 132
    :pswitch_a
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalSwappablePss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 133
    :pswitch_b
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setNativePrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 134
    :pswitch_c
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setDalvikSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 170
    :pswitch_d
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 173
    :pswitch_e
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalPrivateClean(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 174
    :pswitch_f
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setDalvikPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    goto/16 :goto_0

    .line 226
    :cond_10
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 227
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x794ab328 -> :sswitch_f
        -0x7524fc16 -> :sswitch_e
        -0x75180e8d -> :sswitch_d
        -0x73fd037c -> :sswitch_c
        -0x6dfc3e3a -> :sswitch_b
        -0x6b43b763 -> :sswitch_a
        -0x5b211500 -> :sswitch_9
        -0x5b142777 -> :sswitch_8
        -0x45ce5e60 -> :sswitch_7
        -0x3c18a0c7 -> :sswitch_6
        -0x32a89714 -> :sswitch_5
        -0x844ce2a -> :sswitch_4
        0x47b0433f -> :sswitch_3
        0x502c1d3d -> :sswitch_2
        0x6783b7e7 -> :sswitch_1
        0x7651cef5 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static m(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "parameterValue"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_1
    const-string v2, "rolloutVariant"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_2
    const-string v2, "templateVersion"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_3
    const-string v2, "parameterKey"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 21
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 22
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;->setParameterValue(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;

    goto :goto_0

    .line 23
    :pswitch_1
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->u(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;->setRolloutVariant(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;

    goto :goto_0

    .line 32
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;->setTemplateVersion(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;

    goto :goto_0

    .line 33
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;->setParameterKey(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;

    goto :goto_0

    .line 46
    :cond_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 47
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x5b919a0a -> :sswitch_3
        -0x3d3b3502 -> :sswitch_2
        0x417d8d94 -> :sswitch_1
        0x4305cf48 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static n(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "assignments"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 12
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 13
    :cond_0
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda7;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda7;-><init>()V

    .line 14
    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 15
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;->setRolloutAssignments(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;

    goto :goto_0

    .line 23
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 24
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    move-result-object p0

    return-object p0
.end method

.method private static o(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "importance"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_1
    const-string v2, "name"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_2
    const-string v2, "frames"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 19
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 20
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    goto :goto_0

    .line 23
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    goto :goto_0

    .line 26
    :pswitch_2
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda4;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda4;-><init>()V

    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    .line 27
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_3

    const/4 v1, 0x0

    :cond_3
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->setFrames(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    goto :goto_0

    .line 34
    :cond_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 35
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x4b7d7b5a -> :sswitch_2
        0x337a8b -> :sswitch_1
        0x7eb2da74 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static p(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "filename"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "contents"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    invoke-static {v1, v2}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;->setContents([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;

    goto :goto_0

    .line 16
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;->setFilename(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;

    goto :goto_0

    .line 26
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 28
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;

    move-result-object p0

    return-object p0
.end method

.method private static q(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "files"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "orgId"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;->setOrgId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;

    goto :goto_0

    .line 16
    :cond_1
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda3;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda3;-><init>()V

    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;->setFiles(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;

    goto :goto_0

    .line 26
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 28
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    move-result-object p0

    return-object p0
.end method

.method private static r(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "access"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "carrier"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->setCarrier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    goto :goto_0

    .line 18
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->setAccess(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;

    goto :goto_0

    .line 26
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 27
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object p0

    return-object p0
.end method

.method private static s(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "importance"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_1
    const-string v2, "defaultProcess"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_2
    const-string v2, "processName"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_3
    const-string v2, "pid"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 21
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 22
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;

    goto :goto_0

    .line 25
    :pswitch_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;->setDefaultProcess(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;

    goto :goto_0

    .line 26
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;->setProcessName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;

    goto :goto_0

    .line 29
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextInt()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;->setPid(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;

    goto :goto_0

    .line 42
    :cond_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 44
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        0x1b18b -> :sswitch_3
        0xc0f3d9a -> :sswitch_2
        0x650184ee -> :sswitch_1
        0x7eb2da74 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static t(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 4

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_f

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, -0x1

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    const-string v2, "platform"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto/16 :goto_1

    :cond_0
    const/16 v3, 0xe

    goto/16 :goto_1

    :sswitch_1
    const-string v2, "network"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto/16 :goto_1

    :cond_1
    const/16 v3, 0xd

    goto/16 :goto_1

    :sswitch_2
    const-string v2, "protocolVersion"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto/16 :goto_1

    :cond_2
    const/16 v3, 0xc

    goto/16 :goto_1

    :sswitch_3
    const-string v2, "clientTime"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto/16 :goto_1

    :cond_3
    const/16 v3, 0xb

    goto/16 :goto_1

    :sswitch_4
    const-string v2, "sessionId"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto/16 :goto_1

    :cond_4
    const/16 v3, 0xa

    goto/16 :goto_1

    :sswitch_5
    const-string v2, "sampleRate"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto/16 :goto_1

    :cond_5
    const/16 v3, 0x9

    goto/16 :goto_1

    :sswitch_6
    const-string v2, "utdid"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    goto/16 :goto_1

    :cond_6
    const/16 v3, 0x8

    goto/16 :goto_1

    :sswitch_7
    const-string v2, "eventTime"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    goto :goto_1

    :cond_7
    const/4 v3, 0x7

    goto :goto_1

    :sswitch_8
    const-string v2, "uuid"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    goto :goto_1

    :cond_8
    const/4 v3, 0x6

    goto :goto_1

    :sswitch_9
    const-string v2, "user"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    goto :goto_1

    :cond_9
    const/4 v3, 0x5

    goto :goto_1

    :sswitch_a
    const-string v2, "sdk"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_a

    goto :goto_1

    :cond_a
    const/4 v3, 0x4

    goto :goto_1

    :sswitch_b
    const-string v2, "app"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_b

    goto :goto_1

    :cond_b
    const/4 v3, 0x3

    goto :goto_1

    :sswitch_c
    const-string v2, "payload"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_c

    goto :goto_1

    :cond_c
    const/4 v3, 0x2

    goto :goto_1

    :sswitch_d
    const-string v2, "device"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_d

    goto :goto_1

    :cond_d
    const/4 v3, 0x1

    goto :goto_1

    :sswitch_e
    const-string v2, "eventId"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_e

    goto :goto_1

    :cond_e
    const/4 v3, 0x0

    :goto_1
    packed-switch v3, :pswitch_data_0

    .line 54
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto/16 :goto_0

    .line 55
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPlatform(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 79
    :pswitch_1
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->r(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setNetwork(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 80
    :pswitch_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setProtocolVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 116
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setClientTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 117
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setSessionId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 144
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextDouble()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setSampleRate(D)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 145
    :pswitch_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setUtdid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 169
    :pswitch_7
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setEventTime(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 170
    :pswitch_8
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setUuid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 185
    :pswitch_9
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->y(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setUser(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 186
    :pswitch_a
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->v(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setSdk(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 189
    :pswitch_b
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 210
    :pswitch_c
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->w(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 211
    :pswitch_d
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->e(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 212
    :pswitch_e
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setEventId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    goto/16 :goto_0

    .line 255
    :cond_f
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 256
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x520bc2ab -> :sswitch_e
        -0x4f94e1aa -> :sswitch_d
        -0x2ee41e72 -> :sswitch_c
        0x17a21 -> :sswitch_b
        0x1bc3a -> :sswitch_a
        0x36ebcb -> :sswitch_9
        0x36f3bb -> :sswitch_8
        0x1df5c87 -> :sswitch_7
        0x6a6fd80 -> :sswitch_6
        0x88751aa -> :sswitch_5
        0x243a3e51 -> :sswitch_4
        0x41b5dd38 -> :sswitch_3
        0x687a0b20 -> :sswitch_2
        0x6de15a2e -> :sswitch_1
        0x6fbd6873 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static u(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "variantId"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "rolloutId"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;->setRolloutId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;

    goto :goto_0

    .line 18
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;->setVariantId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;

    goto :goto_0

    .line 25
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 26
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;

    move-result-object p0

    return-object p0
.end method

.method private static v(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "name"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "version"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;->setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;

    goto :goto_0

    .line 16
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;->setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;

    goto :goto_0

    .line 27
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 29
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    move-result-object p0

    return-object p0
.end method

.method private static w(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
    .locals 5

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    const/4 v3, 0x2

    const/4 v4, -0x1

    sparse-switch v2, :sswitch_data_0

    goto :goto_1

    :sswitch_0
    const-string v2, "crashed"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    const/4 v4, 0x5

    goto :goto_1

    :sswitch_1
    const-string v2, "log"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/4 v4, 0x4

    goto :goto_1

    :sswitch_2
    const-string v2, "events"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    const/4 v4, 0x3

    goto :goto_1

    :sswitch_3
    const-string v2, "endedAt"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    move v4, v3

    goto :goto_1

    :sswitch_4
    const-string v2, "identifier"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    const/4 v4, 0x1

    goto :goto_1

    :sswitch_5
    const-string v2, "startedAt"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    goto :goto_1

    :cond_5
    const/4 v4, 0x0

    :goto_1
    packed-switch v4, :pswitch_data_0

    .line 28
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 29
    :pswitch_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextBoolean()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setCrashed(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    goto :goto_0

    .line 32
    :pswitch_1
    invoke-static {p0}, Lcom/aliyun/emas/apm/crash/p;->x(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setLog(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    goto :goto_0

    .line 35
    :pswitch_2
    new-instance v1, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda6;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/crash/p$$ExternalSyntheticLambda6;-><init>()V

    invoke-static {p0, v1}, Lcom/aliyun/emas/apm/crash/p;->a(Landroid/util/JsonReader;Lcom/aliyun/emas/apm/crash/p$a;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setEvents(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    goto :goto_0

    .line 36
    :pswitch_3
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setEndedAt(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    goto/16 :goto_0

    .line 37
    :pswitch_4
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v1

    .line 38
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setIdentifierFromUtf8Bytes([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    goto/16 :goto_0

    .line 42
    :pswitch_5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setStartedAt(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    goto/16 :goto_0

    .line 61
    :cond_6
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 63
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p0

    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        -0x7ee2d36c -> :sswitch_5
        -0x60775357 -> :sswitch_4
        -0x5fc4f373 -> :sswitch_3
        -0x4cf81ee7 -> :sswitch_2
        0x1a344 -> :sswitch_1
        0x3d1e2286 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static x(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "content"

    .line 6
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 7
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;->setContent(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;

    goto :goto_0

    .line 9
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 12
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 13
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    move-result-object p0

    return-object p0
.end method

.method private static y(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    move-result-object v0

    .line 3
    invoke-virtual {p0}, Landroid/util/JsonReader;->beginObject()V

    .line 4
    :goto_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 5
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextName()Ljava/lang/String;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    const-string v2, "id"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "nick"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 14
    invoke-virtual {p0}, Landroid/util/JsonReader;->skipValue()V

    goto :goto_0

    .line 15
    :cond_0
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->setNick(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    goto :goto_0

    .line 16
    :cond_1
    invoke-virtual {p0}, Landroid/util/JsonReader;->nextString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->setId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;

    goto :goto_0

    .line 27
    :cond_2
    invoke-virtual {p0}, Landroid/util/JsonReader;->endObject()V

    .line 28
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 2

    .line 4
    :try_start_0
    new-instance v0, Landroid/util/JsonReader;

    new-instance v1, Ljava/io/StringReader;

    invoke-direct {v1, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 5
    :try_start_1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/p;->f(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6
    :try_start_2
    invoke-virtual {v0}, Landroid/util/JsonReader;->close()V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 7
    :try_start_3
    invoke-virtual {v0}, Landroid/util/JsonReader;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v0

    :try_start_4
    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p1
    :try_end_4
    .catch Ljava/lang/IllegalStateException; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    move-exception p1

    .line 10
    new-instance v0, Ljava/io/IOException;

    invoke-direct {v0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/p;->a:Lcom/google/firebase/encoders/DataEncoder;

    .line 3
    invoke-interface {v0, p1}, Lcom/google/firebase/encoders/DataEncoder;->encode(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/p;->a:Lcom/google/firebase/encoders/DataEncoder;

    .line 2
    invoke-interface {v0, p1}, Lcom/google/firebase/encoders/DataEncoder;->encode(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/p;->a:Lcom/google/firebase/encoders/DataEncoder;

    .line 1
    invoke-interface {v0, p1}, Lcom/google/firebase/encoders/DataEncoder;->encode(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public b(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;
    .locals 2

    .line 1
    :try_start_0
    new-instance v0, Landroid/util/JsonReader;

    new-instance v1, Ljava/io/StringReader;

    invoke-direct {v1, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2
    :try_start_1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/p;->s(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3
    :try_start_2
    invoke-virtual {v0}, Landroid/util/JsonReader;->close()V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 4
    :try_start_3
    invoke-virtual {v0}, Landroid/util/JsonReader;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v0

    :try_start_4
    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p1
    :try_end_4
    .catch Ljava/lang/IllegalStateException; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    move-exception p1

    .line 7
    new-instance v0, Ljava/io/IOException;

    invoke-direct {v0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method public c(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 2

    .line 1
    :try_start_0
    new-instance v0, Landroid/util/JsonReader;

    new-instance v1, Ljava/io/StringReader;

    invoke-direct {v1, p1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Landroid/util/JsonReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2
    :try_start_1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/p;->t(Landroid/util/JsonReader;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3
    :try_start_2
    invoke-virtual {v0}, Landroid/util/JsonReader;->close()V
    :try_end_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 4
    :try_start_3
    invoke-virtual {v0}, Landroid/util/JsonReader;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v0

    :try_start_4
    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p1
    :try_end_4
    .catch Ljava/lang/IllegalStateException; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    move-exception p1

    .line 7
    new-instance v0, Ljava/io/IOException;

    invoke-direct {v0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method
